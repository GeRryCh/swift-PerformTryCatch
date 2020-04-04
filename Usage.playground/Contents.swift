import UIKit

/* Examples for
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


