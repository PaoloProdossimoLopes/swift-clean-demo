//
//  XCTestCase+Extensions.swift
//  DataTests
//
//  Created by Paolo Prodossimo Lopes on 16/07/22.
//

import XCTest

extension XCTestCase {
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "❌ ERROR: Instance of \(instance!) does not deallocated ...",
                file: file, line: line
            )
        }
    }
    
}
