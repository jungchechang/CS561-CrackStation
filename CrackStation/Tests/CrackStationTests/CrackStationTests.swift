import XCTest
@testable import CrackStation

final class CrackStationTests: XCTestCase {
    
    func testCrackStation() throws{
        let testString = CrackStation().crack(password: "ae4f281df5a5d0ff3cad6371f76d5c29b6d953ec")
        
        XCTAssertEqual("B",testString)
        XCTAssertNotNil(testString)
    }
}
