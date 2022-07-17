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
