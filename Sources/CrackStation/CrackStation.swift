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
    func decrypt(shaHash: String) -> String? {
        return lookupTable[shaHash]
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
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
