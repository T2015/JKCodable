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
        return nil
    }
    
    
    static func fromJsonDic(_ jsonDic: [String: Any]) -> T? {
        
        if let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [.prettyPrinted]) {
            return fromJsonData(data)
        }
        return nil
    }
    
    
    static func fromJsonString(_ jsonString: String) -> Self? {
        
        if let data = jsonString.data(using: .utf8) {
            return fromJsonData(data)
        }
        return nil
    }
}

public extension Encodable {
    
    typealias T = Self
    
    func toJsonString() -> String? {
        
        if let data = toJsonData() {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    func toJsonDic() -> [String: Any]? {
        
        if let data = toJsonData() {
            
            if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                return dic as? [String: Any]
            }
        }
        return nil
    }
    
    
    func toJsonData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            return data
        }
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
        return nil
    }
    
    
    func toDicArray() -> [[String: Any]]? {
        
        if let data = toJsonData() {
            if let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                return dic as? [[String: Any]]
            }
        }
        return nil
    }
    
    static func fromDicArray(_ jsonDic: [String: Any]) -> [Element]? {
        
        if let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [.prettyPrinted]) {
            return fromJsonData(data)
        }
        return nil
    }
    
    
    
    
    func toJsonData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            return data
        }
        return nil
    }
    
    static func fromJsonData(_ jsonData: Data) -> [Element]? {
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode([Element].self, from: jsonData) {
            return obj
        }
        return nil
    }
    
}








