import Foundation

import UIKit


/// Use this method for throwing a custom error
/// - Parameters:
///   - expression: Throwing expression
///   - errorExpression: An thrown `Error` if expression fails
public func perform<T>(_ expression: @autoclosure () throws -> T,
                       onThrow errorExpression: @autoclosure () -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorExpression()
    }
}

public func perform(_ expression: @autoclosure () throws -> (),
                    onThrow errorCallback: (Error) -> ()) {
    do {
        try expression()
    } catch {
        errorCallback(error)
    }
}

public func perform<T>(_ expression: @autoclosure () throws -> T,
                       errorTransform: (Error) -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorTransform(error)
    }
}

public func perform<T>(_ expression: @autoclosure () throws -> T) -> T? {
    do {
        return try expression()
    } catch {
        return nil
    }
}
