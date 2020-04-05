import Foundation

import UIKit


/// Use this method for throwing a custom error
/// - Parameters:
///   - expression: Throwing expression
///   - errorExpression: An thrown `Error` if expression fails
public func perform<T>(_ expression: @autoclosure () throws -> T,
                       orThrow errorExpression: @autoclosure () -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorExpression()
    }
}

/// Use this method for manipulating the original error before throw
/// - Parameters:
///   - expression: Throwing expression
///   - errorTransform: The closure to manipulate a thrown error. Returns an error that is eventually thrown.
public func perform<T>(_ expression: @autoclosure () throws -> T,
                       errorTransform: (Error) -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorTransform(error)
    }
}

/// Use this method to provide for each throwing expressions what should be done if an error is thrown.
/// In contrast, this method doesn't throw, but used as a wrapper around `do-try-catch` dance.
/// - Parameters:
///   - expression: Throwing expression
///   - errorCallback: The closure is being called when error is thrown.
public func perform(_ expression: @autoclosure () throws -> (),
                    errorCallback: (Error) -> ()) {
    do {
        try expression()
    } catch {
        errorCallback(error)
    }
}
