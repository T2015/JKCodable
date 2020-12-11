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
    
    static func fromData(_ data: Data?) -> T? {
        
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        var obj: T? = nil
        
        do {
            obj = try decoder.decode(T.self, from: data)
        } catch{
            print("JKCodable.Decodable.fromJsonData: \n\(error)")
        }
        
        return obj
    }
    
    
    static func fromJson(_ json: Any?) -> T? {
        
        guard let json = json else { return nil }
        
        if let data = Data.fromJson(json) {
            return fromData(data)
        }
        return nil
    }
    
}

public extension Encodable {
    
    func toJson() -> Any? {
        
        var result: Any? = nil
        guard let data = toData() else { return result }
        
        result = data.toJson()
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
    
    
    typealias T = Self
    
    static func fromJson(_ json: Any?) -> T? {
        let data = Data.fromJson(json)
        return fromData(data)
    }
    
    static func fromData(_ data: Data?) -> T? {
        
        var result: T? = nil
        guard let data = data else { return result }
        
        do {
            result = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? T
        } catch {
            print("JKCodable.Array.fromData: \n \(error)")
        }
        return result
    }
    
    func toJson() -> Any? {
        let encoder = JSONEncoder()
        var result: Any? = nil
        
        do {
            result = try encoder.encode(self)
        } catch {
            print("JKCodable.Array.toJson: \n \(error)")
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
    
        var result: Data? = nil
        guard let json = json else { return result }
        
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


struct Json: Codable {
    
    
}



