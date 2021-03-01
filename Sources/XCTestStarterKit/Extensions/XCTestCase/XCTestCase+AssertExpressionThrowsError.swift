import Foundation
import XCTest


extension XCTestCase {
    
    /// Helper for asserting that an expression throws an error of a given type.
    ///
    /// Use this in tandem with custom Error types that conform to `Equatable`
    public func assert<Success, Failure>(
        _ result: Result<Success, Failure>,
        throws error: Failure,
        in file: StaticString = #file,
        line: UInt = #line
    ) where Failure: Error & Equatable {
        var thrownError: Error?
        
        XCTAssertThrowsError(
            try expression(),
            file: file,
            line: line
        ) {
            thrownError = $0
        }
        
        XCTAssertTrue(
            thrownError is Failure,
            "Unexpected error type: \(type(of: thrownError))",
            file: file,
            line: line
        )

        XCTAssertEqual(
            thrownError as? Failure,
            error,
            file: file,
            line: line
        )
    }
}
