//
// Created by CypherPoet on 2/27/21.
// ✌️
//


import XCTest
import Combine
@testable import XCTestStarterKit


class XCTestCase_AssertResultCompletesWithErrorTests: XCTestCase {

    private enum CustomEquatableError: Swift.Error, Equatable {
        case problematicOpinion(String)
    }
    
    
    private enum CustomComplexError: LocalizedError {
        case serverFailure
        case outOfThisWorld(Error)

        var errorDescription: String? {
            switch self {
            case .serverFailure:
                return "Ouch"
            case .outOfThisWorld(let error):
                return error.localizedDescription
            }
        }
    }
}


// MARK: - Lifecycle
extension XCTestCase_AssertResultCompletesWithErrorTests {

    override func setUpWithError() throws {
        // Put setup code here.
        // This method is called before the invocation of each
        // test method in the class.
        try super.setUpWithError()
    }


    override func tearDownWithError() throws {
        // Put teardown code here.
        // This method is called after the invocation of each
        // test method in the class.
        try super.tearDownWithError()
    }
}



extension XCTestCase_AssertResultCompletesWithErrorTests {

    func test_Asserting_WhenErrorIsEquatable_VerifiesMatch() throws {
        let expectedError = CustomEquatableError.problematicOpinion("I like pancakes")
        let result: Result<Void, CustomEquatableError> = .failure(expectedError)
        
        assert(result, completesWith: expectedError)
    }

    
    func test_Asserting_GivenNonEquatableErrorType_WhenFailureTypeIsExpected_Passes() throws {
        let expectedError = CustomComplexError.outOfThisWorld(URLError(.dnsLookupFailed))
        
        let result: Result<Void, CustomComplexError> = .failure(expectedError)
        
        assert(result, completesWith: expectedError)
    }
    
    
    func test_Asserting_GivenNonEquatableErrorType_WhenFailureTypeIsUnexpected_Fails() throws {
        let expectedError = CustomComplexError.outOfThisWorld(URLError(.dnsLookupFailed))
        let unexpectedError1 = CustomComplexError.serverFailure
        let unexpectedError2 = CustomComplexError.outOfThisWorld(URLError(.badURL))
        
        let result: Result<Void, CustomComplexError> = .failure(expectedError)
        
        XCTExpectFailure("Result completed with unexpected error.") {
            assert(result, completesWith: unexpectedError1)
            assert(result, completesWith: unexpectedError2)
        }
    }
}
