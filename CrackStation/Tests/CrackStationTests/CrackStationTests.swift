import XCTest
import CryptoKit
@testable import CrackStation

final class CrackStationTests: XCTestCase {
    
    func testCrackStation() throws{
        let testString = CrackStation().crack(password: "")
        XCTAssertEqual(nil,testString)
    }
    
    func testAllOneLetterSha1Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            // Given
            let password = String(letter)
            let shaHash = encryptUsingSha1(password)
            // When
            let crackedPassword = CrackStation().crack(password: shaHash)
            // Then
            XCTAssertEqual(crackedPassword, password)
            
        }
    }
    
    func testAllOneLetterSha256Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            // Given
            let password = String(letter)
            let shaHash = encryptUsingSha256(password)
            // When
            let crackedPassword = CrackStation().crack(password: shaHash)
            // Then
            XCTAssertEqual(crackedPassword, password)
        }
        
    }
    
    func testAllTneLetterSha1Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            for letter2 in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"{
                
                let password = String(letter)+String(letter2)
                let shaHash = encryptUsingSha1(password)
                // When
                let crackedPassword = CrackStation().crack(password: shaHash)
                // Then
                XCTAssertEqual(crackedPassword, password)
                
            }
            
        }
        
    }
    
    func testAllTwoLetterSha256Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            for letter2 in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"{
                
                let password = String(letter)+String(letter2)
                let shaHash = encryptUsingSha256(password)
                // When
                let crackedPassword = CrackStation().crack(password: shaHash)
                // Then
                XCTAssertEqual(crackedPassword, password)
                
            }
            
        }
        
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
