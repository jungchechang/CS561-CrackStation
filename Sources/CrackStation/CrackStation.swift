import Foundation

public class CrackStation: Decrypter {
    private let lookupTable: [String : String]
    // load sha1 or sha256 dicyionary from data.json
    required public init() {
        do{
            lookupTable =  try CrackStation.loadDictionaryFromDisk()
        }
        catch{
            lookupTable = ["":""]
        }
    }
    public func decrypt(shaHash: String) -> String? {
        return lookupTable[shaHash]
    }
   static func loadDictionaryFromDisk() throws -> [String : String] {
        guard let path = Bundle.module.url(forResource: "data", withExtension: "json") else { return [:] }
        let data = try Data(contentsOf: path)
        let jsonResult = try JSONSerialization.jsonObject(with: data)
        
        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
            return lookupTable
        } else {
            return [:]
        }
    }
}
