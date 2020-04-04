//
//  tryOptional.swift
//
//  Created by German Velibekov on 06/02/2020.
//  Copyright © 2020 German Velibekov. All rights reserved.
//

import Foundation

public struct NilError<T>: Error, CustomStringConvertible {
    private let _description: String
    
    init(optional: Optional<T>) {
        _description = "Nil returned for optional of type: \(T.self)"
    }
    
    init(optional: Optional<T>, file: String, line: Int) {
        _description = "Nil returned for optional of type: \(T.self) at \(file) line: \(line)"
    }
    
    public var description: String {
        return _description
    }
}

prefix operator ??

public extension Optional {
    func unwrap(file: String = #file,
                line: Int = #line) throws -> Wrapped {
        guard let unwrapped = self else {
            throw NilError(optional: self,
                                   file: file,
                                   line: line)
        }
        return unwrapped
    }
    
    static prefix func ?? (optional: Optional) throws -> Wrapped {
        guard let unwrapped = optional else {
            throw NilError(optional: optional)
        }
        return unwrapped
    }
}
