import Foundation
import XCTest


extension XCTestCase {

    /// Helper for asserting that an expression throws an error of a given type.
    ///
    /// Use this in tandem with custom Error types that conform to `Equatable`
    public func assert<SuccessValue, ExpectedError>(
        _ expression: @autoclosure () throws -> SuccessValue,
        throws error: ExpectedError,
        in file: StaticString = #file,
        line: UInt = #line
    ) where ExpectedError: Error & Equatable {
        var thrownError: Error?
        
        XCTAssertThrowsError(
            try expression(),
            file: file,
            line: line
        ) {
            thrownError = $0
        }
        
        XCTAssertTrue(
            thrownError is ExpectedError,
            "Unexpected error type: \(type(of: thrownError))",
            file: file,
            line: line
        )

        XCTAssertEqual(
            thrownError as? ExpectedError,
            error,
            file: file,
            line: line
        )
    }

}
