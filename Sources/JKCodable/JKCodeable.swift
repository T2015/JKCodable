//
// project SPMManager
// 
// Created By Junky on 2020/12/21
// email: <#Email#>
// github: <#github#>
//
// 
// 
// JKCodeable.swift
// desc: None






import Foundation


public protocol JKCodeable: Codable {}

public extension JKCodeable {
    
    typealias S = Self
    
    
    
    static func fromData(_ data: Data?) -> S? {
        
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        var obj: S? = nil
        
        do {
            obj = try decoder.decode(S.self, from: data)
        } catch{
            print("JKCodable.Decodable.fromJsonData: \n\(error)")
        }
        
        return obj
    }
    
    
    static func fromJson(_ json: Any?) -> S? {
        
        guard let json = json else { return nil }
        
        if let data = Data.fromJson(json) {
            return fromData(data)
        }
        return nil
    }
    
    
    func toJson() -> Any? {
        
        
        guard let data = toData() else { return nil }
        let result = data.toJson()
        return result
    }
    
    
    func toData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        var result: Data? = nil
        
        do {
            result = try encoder.encode(self)
        } catch {
            print("JKCodable.Encodable.toJsonData: \n \(error)")
        }
        
        return result
    }
    
}



public extension Array where Element: Codable {
    
    
    typealias S = Self
    
    static func fromJson(_ json: Any?) -> S? {
        let data = Data.fromJson(json)
        return fromData(data)
    }
    
    
    
    func toJson() -> Any? {
        let encoder = JSONEncoder()
        var result: Data? = nil
        
        do {
            result = try encoder.encode(self)
        } catch {
            print("JKCodable.Array.toJson: \n \(error)")
        }
        return result?.toJson()
    }
    
    
    
    static func fromData(_ data: Data?) -> S? {

        guard let tmp = data else { return nil }
        var result: S? = nil
        do {
            result = try JSONDecoder().decode(S.self, from: tmp)
        } catch {
            print("JKCodable.Array.fromData: \n \(error)")
        }
        return result
    }
    
    
    func toData() -> Data? {
        let json = toJson()
        return Data.fromJson(json)
    }
    

}


extension Data {
    
    static func fromJson(_ json: Any?) -> Self? {
    
        guard let json = json else { return nil }
        var result: Data? = nil
        do {
            result = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        } catch {
            print("JKCodable.Data.fromJson: \n \(error)")
        }
        return result
    }
    
    func toJson() -> Any? {
        var result: Any? = nil
        do {
            result = try JSONSerialization.jsonObject(with: self, options: [.mutableContainers])
        } catch {
            print("JKCodable.Data.toJson: \n \(error)")
        }
        return result
    }
    
}



