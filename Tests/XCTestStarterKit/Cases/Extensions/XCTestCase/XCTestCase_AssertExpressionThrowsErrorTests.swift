//
// Created by CypherPoet on 2/27/21.
// ✌️
//


import XCTest
import Combine
@testable import XCTestStarterKit


class XCTestCase_AwaitCompletionOfPublisherTests: XCTestCase {
    typealias StringPublisher = AnyPublisher<String, Never>
    
    private var sut: StringPublisher!
    private var stringToPublish: String!
}


// MARK: - Lifecycle
extension XCTestCase_AwaitCompletionOfPublisherTests {

    override func setUpWithError() throws {
        // Put setup code here.
        // This method is called before the invocation of each
        // test method in the class.
        try super.setUpWithError()
        
        stringToPublish = "Swift 🏎"
        sut = makeSUT(withString: stringToPublish)
    }


    override func tearDownWithError() throws {
        // Put teardown code here.
        // This method is called after the invocation of each
        // test method in the class.
        sut = nil
        stringToPublish = nil

        try super.setUpWithError()
    }
}


// MARK: - Factories
private extension XCTestCase_AwaitCompletionOfPublisherTests {

    func makeSUT(
        withString string: String
    ) -> StringPublisher {
        Just(string)
            .eraseToAnyPublisher()
    }
}


// MARK: - "Given" Helpers (Conditions Exist)
private extension XCTestCase_AwaitCompletionOfPublisherTests {

    func givenSomething() {
        // some state or condition is established
    }
}


// MARK: - "When" Helpers (Actions Are Performed)
private extension XCTestCase_AwaitCompletionOfPublisherTests {

    func whenSomethingHappens() {
        // perform some action
    }
}


// MARK: - Test Initializing with Custom Arguments
extension XCTestCase_AwaitCompletionOfPublisherTests {

    func test_awaitCompletionOfPublisher_WhenComplete_ReturnsAListOfPublisherOutputs() throws {
        let result = try awaitCompletion(of: sut)
        let resultOutput = try XCTUnwrap(result.first)
        
        XCTAssertEqual(resultOutput, stringToPublish)
    }
}
