import UIKit
import EventKit

/* Example for
 public func perform<T>(_ expression: @autoclosure () throws -> T,
                        onThrow errorExpression: @autoclosure () -> Error) throws -> T`
 */

enum SearchError: Error {
    case invalidQuery(String)
    case dataLoadingFailed(URL)
}

func loadSearchData(matching query: String) throws -> Data {
    let urlString = "https://my.api.com/search?q=\(query)"
    
    let url = try perform(??URL(string: urlString),
                          orThrow: SearchError.invalidQuery(query))
    
    return try perform(Data(contentsOf: url),
                       orThrow: SearchError.dataLoadingFailed(url))
}

/* Example for
public func perform<T>(_ expression: @autoclosure () throws -> T,
                       errorTransform: (Error) -> Error) throws -> T
*/
enum UserError: Error {
    case dataLoadingFailed(URL, Error)
}

func loadUserData(id: String) throws -> Data {
    let urlString = "https://my.api.com/user?id=\(id)"
    
    let url = URL(string: urlString)!
    
    return try perform(Data(contentsOf: url)) {
        UserError.dataLoadingFailed(url, $0)
    }
}

/* Example for
public func perform(_ expression: @autoclosure () throws -> (),
                    errorCallback: (Error) -> ())
*/
enum CalendarEventError: Error {
    case unauthorized
    case accessDenied
}

func insertEventToDefaultCalendar(event :EKEvent) throws {
    //...
    switch EKEventStore.authorizationStatus(for: .event) {
    case .authorized:
        //insert event
        break
    case .denied:
        throw CalendarEventError.accessDenied

    //...
    //Taken as part of the example from: https://stackoverflow.com/questions/33213715/swift-throw-from-closure-nested-in-a-function
    default:
        break
    }
}

perform(try insertEventToDefaultCalendar(event: EKEvent())) {
    guard let error = $0 as? CalendarEventError else { return }
    print(error)
}
