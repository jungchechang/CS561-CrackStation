import Foundation

class CrackStation: Decrypter {
    var lookupTable:[String:String] = [:]
    required init() {
        do{
            lookupTable = try loadDictionaryFromDisk()
        }
        catch{
            print("Error")
        }
    }
    public func decrypt(shaHash: String) -> String? {
        return lookupTable[shaHash]
    }
    func loadDictionaryFromDisk() throws -> [String : String] {
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
