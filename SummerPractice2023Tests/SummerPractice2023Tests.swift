import XCTest
@testable import SummerPractice2023

final class SummerPractice2023Tests: XCTestCase {

    func test() throws {
        let networkSerivce = NetworkService()
        networkSerivce.getEvents { result in
            XCTAssertTrue(result.count == 3)
            XCTAssertEqual(result[0].text, "My task")
            XCTAssertEqual(result[0].description, "Описание моего дела")
            XCTAssertEqual(result[0].dateInterval.start.timeIntervalSince1970, 1688733560)
            XCTAssertEqual(result[0].dateInterval.end.timeIntervalSince1970, 1688753560)
        }
    }
}
