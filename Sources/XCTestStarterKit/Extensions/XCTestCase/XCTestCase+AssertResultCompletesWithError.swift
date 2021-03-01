import Foundation
import XCTest


extension XCTestCase {
    
    /// Helper for asserting that a result fails with a specific error.
    ///
    /// This helper compares the `localizedDescription` of the expected and actual
    /// errors to determine whether or not the expected error occurred.
    /// Use this in tandem with custom Error types that _can't_ practically conform to `Equatable`.
    public func assert<Success, Failure>(
        _ result: Result<Success, Failure>,
        completesWith expectedError: Failure,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        switch result {
        case .success:
            XCTFail("No error thrown", file: file, line: line)
        case .failure(let thrownError):
            print(thrownError.localizedDescription)
            print(expectedError.localizedDescription)
            
            XCTAssertEqual(
                thrownError.localizedDescription,
                expectedError.localizedDescription,
                file: file,
                line: line
            )
        }
    }
    
    
    /// Helper for asserting that a result fails with a specific error.
    ///
    /// Use this in tandem with custom Error types that conform to `Equatable`
    public func assert<Success, Failure>(
        _ result: Result<Success, Failure>,
        completesWith expectedError: Failure,
        in file: StaticString = #file,
        line: UInt = #line
    ) where Failure: Equatable {
        switch result {
        case .success:
            XCTFail("No error thrown", file: file, line: line)
        case .failure(let thrownError):
            XCTAssertEqual(thrownError, expectedError)
        }
    }
}
