//
// project EatingToday
//
// Created By Junky on 2020/12/10
// email: <#Email#>
// github: <#github#>
//
//
//
// JKCodable.swift
// desc: None






import Foundation

public extension Decodable {
    
    typealias T = Self
    
    static func fromJsonData(_ jsonData: Data) -> T? {
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(T.self, from: jsonData) {
            return obj
        }
        print("JKCodable.Decodable.fromJsonData: decoder.decode failure")
        return nil
    }
    
    
    static func fromJsonDic(_ jsonDic: [String: Any]) -> T? {
        
        if let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [.prettyPrinted]) {
            return fromJsonData(data)
        }
        print("JKCodable.Decodable.fromJsonDic: JSONSerialization.data failure")
        return nil
    }
    
    
    static func fromJsonString(_ jsonString: String) -> T? {
        
        if let data = jsonString.data(using: .utf8) {
            return fromJsonData(data)
        }
        print("JKCodable.Decodable.fromJsonString: jsonString.data failure")
        return nil
    }
}

public extension Encodable {
    
    typealias T = Self
    
    func toJsonString() -> String? {
        
        if let data = toJsonData() {
            return String(data: data, encoding: .utf8)
        }
        print("JKCodable.Encodable.toJsonString: String.data failure")
        return nil
    }
    
    
    func toJsonDic() -> [String: Any]? {
        
        if let data = toJsonData() {
            
            if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                return dic as? [String: Any]
            }
            print("JKCodable.Encodable.toJsonDic: JSONSerialization.jsonObject failure")
        }
        return nil
    }
    
    
    func toJsonData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            return data
        }
        print("JKCodable.Encodable.toJsonData: encoder.encode failure")
        return nil
    }
    
}



public extension Array where Element: Codable {
    
    func toJsonString() -> String? {
        
        if let data = toJsonData() {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    static func fromJsonString(_ jsonString: String) -> [Element]? {
        
        if let data = jsonString.data(using: .utf8) {
            return fromJsonData(data)
        }
        print("JKCodable.Array.Codable.fromJsonString: jsonString.data failure")
        return nil
    }
    
    
    func toDicArray() -> [[String: Any]]? {
        
        if let data = toJsonData() {
            if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                return dic as? [[String: Any]]
            }
            print("JKCodable.Array.Codable.toDicArray: JSONSerialization.jsonObject failure")
        }
        return nil
    }
    
    static func fromDicArray(_ jsonDic: [String: Any]) -> [Element]? {
        
        if let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [.prettyPrinted]) {
            return fromJsonData(data)
        }
        print("JKCodable.Array.Codable.fromDicArray: JSONSerialization.data failure")
        return nil
    }
    
    
    
    
    func toJsonData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            return data
        }
        print("JKCodable.Array.Codable.toJsonData: encoder.encode failure")
        return nil
    }
    
    static func fromJsonData(_ jsonData: Data) -> [Element]? {
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode([Element].self, from: jsonData) {
            return obj
        }
        print("JKCodable.Array.Codable.fromJsonData: decoder.decode failure")
        return nil
    }
    
}








