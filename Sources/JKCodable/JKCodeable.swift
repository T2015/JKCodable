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
    
    
    
    static func fromData(_ data: Data?) throws -> S? {
        
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        var obj: S? = nil
        
        do {
            obj = try decoder.decode(S.self, from: data)
        } catch{
            throw error
        }
        
        return obj
    }
    
    
    static func fromJson(_ json: Any?) throws -> S? {
        
        guard let json = json else { return nil }
        var result: S? = nil
        do {
            let data = try Data.fromJson(json)
            result = try fromData(data)
        } catch {
            throw error
        }
        return result
    }
    
    
    func toJson() throws -> Any? {
        
        var result: Any? = nil
        
        do {
            let data = try toData()
            if let data = data {
                result = try data.toJson()
            }
        } catch {
            throw error
        }
        return result
    }
    
    
    func toData() throws -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        var result: Data? = nil
        
        do {
            result = try encoder.encode(self)
        } catch {
            throw error
        }
        
        return result
    }
    
}



public extension Array where Element: JKCodeable {
    
    
    typealias S = Self
    
    static func fromJson(_ json: Any?) throws -> S? {
        
        var result: S? = nil
        
        do {
            let data = try Data.fromJson(json)
            result = try fromData(data)
        } catch {
            throw error
        }
        return result
    }
    
    
    
    func toJson() throws -> Any? {
        let encoder = JSONEncoder()
        var result: Any? = nil
        
        do {
            let data = try encoder.encode(self)
            result = try data.toJson()
        } catch {
            throw error
        }
        return result
    }
    
    
    
    static func fromData(_ data: Data?) throws -> S? {

        guard let tmp = data else { return nil }
        var result: S? = nil
        do {
            result = try JSONDecoder().decode(S.self, from: tmp)
        } catch {
            throw error
        }
        return result
    }
    
    
    func toData() throws -> Data? {
        
        var result: Data? = nil
        
        do {
            let json = try toJson()
            result = try Data.fromJson(json)
        } catch {
            throw error
        }
        return result
    }
    

}


extension Data {
    
    static func fromJson(_ json: Any?) throws -> Self? {
    
        guard let json = json else { return nil }
        var result: Data? = nil
        do {
            result = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        } catch {
            throw error
        }
        return result
    }
    
    func toJson() throws -> Any? {
        var result: Any? = nil
        do {
            result = try JSONSerialization.jsonObject(with: self, options: [.mutableContainers])
        } catch {
            throw error
        }
        return result
    }
    
}



