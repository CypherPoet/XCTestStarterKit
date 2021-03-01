//
// Created by CypherPoet on 2/27/21.
// ✌️
//


import XCTest
import Combine
@testable import XCTestStarterKit


class XCTestCase_AssertExpressionThrowsErrorTests: XCTestCase {

    private enum CustomError: Swift.Error, Equatable {
        case oops
        case notAgain(Int)
        case problematicOpinion(String)
    }
}


// MARK: - Lifecycle
extension XCTestCase_AssertExpressionThrowsErrorTests {

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
        try super.setUpWithError()
    }
}


// MARK: - "Given" Helpers (Conditions Exist)
private extension XCTestCase_AssertExpressionThrowsErrorTests {

    func givenSomething() {
        // some state or condition is established
    }
}


// MARK: - "When" Helpers (Actions Are Performed)
private extension XCTestCase_AssertExpressionThrowsErrorTests {

    func whenSomethingHappens() {
        // perform some action
    }
}


extension XCTestCase_AssertExpressionThrowsErrorTests {

    func test_assertExpressionThrowsError_GivenCustomError_ComparesAgainstErrorCase() throws {
        let expectedError = CustomError.oops

        func performThrow() throws {
            throw expectedError
        }

        assert(try performThrow(), throws: expectedError)
    }
    
    
    func test_assertExpressionThrowsError_GivenCustomErrorWithAssociatedValue_ComparesAgainstErrorCaseAndValue() throws {
        let expectedError = CustomError.problematicOpinion("I like pancakes")

        func performThrow() throws {
            throw expectedError
        }

        assert(try performThrow(), throws: expectedError)
    }
}
