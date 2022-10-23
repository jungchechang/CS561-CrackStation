import Foundation
import CryptoKit

@available(macOS 10.15, *)
public struct CrackStation {
    
    public init() {
        
    }
    func encryptUsingSha1(from input: String) -> String {
        let inputData = Data(input.utf8)
        let output = Insecure.SHA1.hash(data: inputData)
        return output.description
    }
    let value = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    /// Returns the cracked plain-text password.
    /// If unable to crack, then returns nil.
    public func crack(password:String) ->String?{
        var plainTextPasswords: [String: String]=[:]
        for i in value{
            plainTextPasswords[encryptUsingSha1(from: i)] = i
        }
        let v =  plainTextPasswords["SHA1 digest: \(password)"]
        return v
    }
}
