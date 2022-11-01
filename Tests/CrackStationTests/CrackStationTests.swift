import CryptoKit
import XCTest
@testable import CrackStation
final class CrackStationTests: XCTestCase {
    private let crackStation =  CrackStation()

    // MARK: - Happy path
    func testAllOneLetterSha1Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            // Given
            let password = String(letter)
            let shaHash = encryptUsingSha1(password)

            // When
            let crackedPassword = crackStation.decrypt(shaHash: shaHash)

            // Then
            XCTAssertEqual(crackedPassword, password)
        }
    }

    func testTwoLetterSha1_aa() throws {
        // Given
        let password = "aaa"
        let shaHash = encryptUsingSha1(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, password)
    }

    func testTwoLetterSha1_99() throws {
        // Given
        let password = "99!"
        let shaHash = encryptUsingSha1(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, password)
    }

    func testTwoLetterSha1_otherCases() throws {
        // TODO: Write
    }

    // MARK: - Edge cases / rainy day scenarios
    func testEmptyString() throws {
        // Given
        let password = ""
        let shaHash = encryptUsingSha1(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, nil)
    }

    func testInvalidShaHash() throws {
        // TODO: Write
    }

    private func encryptUsingSha1(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA 1 digest: "
        let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
        let shaHash = String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    }
    private func encryptUsingSha256(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA 256 digest: "
        let shaHashDescription = String(SHA256.hash(data: dataToHash).description)
        let shaHash =  String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    }
}
