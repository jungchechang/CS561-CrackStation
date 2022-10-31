import Foundation
import CryptoKit

@available(macOS 10.15, *)
public struct CrackStation: Decrypter {
    
    public init() {
        buildDict()
    }
    private var plainTextPasswords: [String: String]=[:]
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

    func convertDictionaryToString(dict:[String:AnyObject]) -> String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))

            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }

    private mutating func buildDict(){
        let value = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        for x in value{
            plainTextPasswords[encryptUsingSha1(x)] = x
            //plainTextPasswords[encryptUsingSha256(x)] = x
            for y in value{
                plainTextPasswords[encryptUsingSha1(x+y)] = x+y
            }
        }
    }
    
    public func decrypt(shaHash: String) -> String? {
        return plainTextPasswords[shaHash]
    }
}
