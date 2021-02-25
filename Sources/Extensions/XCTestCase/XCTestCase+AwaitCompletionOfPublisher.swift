import Foundation
import Combine
import XCTest

//
// References:
//  --: https://www.swiftbysundell.com/articles/testing-networking-logic-in-swift/
//

extension XCTestCase {
    
    public func awaitCompletion<PublisherType: Publisher>(
        of publisher: PublisherType,
        timeout: TimeInterval = 10
    ) throws -> [PublisherType.Output] {
        let publisherCompleted = expectation(
            description: "Awaiting publisher completion"
        )
        
        var completion: Subscribers.Completion<PublisherType.Failure>?
        var output = [PublisherType.Output]()
        
        let subscription = publisher.sink(
            receiveCompletion: {
                completion = $0
                publisherCompleted.fulfill()
            },
            receiveValue: {
                output.append($0)
            }
        )
        
        // Our test execution will stop at this point until our
        // expectation has been fulfilled, or until the given timeout
        // interval has elapsed:
        waitForExpectations(timeout: timeout)
        
        
        switch completion {
        case .failure(let error):
            throw error
        case .finished:
            return output
        case nil:
            // If we enter this code path, then our test has
            // already been marked as failing, since our
            // expectation was never fullfilled.
            subscription.cancel()
            return []
        }
    }
}
