//
// project SPMManager
// 
// Created By Junky on 2020/12/18
// email: <#Email#>
// github: <#github#>
//
// 
// 
// Cache.swift
// desc: None






import Foundation


/// 缓存协议，遵循协议即可获得相应功能
protocol JKCacheable: Codable {
    
    /// 保存路径
    static var directoryPath: String { get }
    /// 保存文件名
    static var fileName: String { get }
}

extension JKCacheable {

    typealias T = Self

    
    static var directoryPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/JKCaches"
    }
    
    static var fileName: String {
        return "\(T.self)"
    }
    
    
    /// 保存
    /// - Throws: 异常
    /// - Returns: 返回保存路径
    @discardableResult func setCache() throws -> String? {

        let path: String = T.getFilePath()
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try FileManager.default.createDirectoryIfNoExist(T.directoryPath)
            try data.write(to: URL(fileURLWithPath: path))
        } catch {
            throw error
        }
        return path
    }

    
    /// 获取
    /// - Throws: 异常
    /// - Returns: 返回实例
    static func getCache() throws -> T? {
        
        var result: T? = nil
        let path: String = T.getFilePath()
        let decoder = JSONDecoder()
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: path))
            result = try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
        return result
    }
    
    
    /// 路径
    /// - Returns: 路径
    static func getFilePath() -> String {
        return directoryPath + "/" + T.fileName
    }
    

}


extension Array where Element: JKCacheable {
    
    
    typealias T = Self

    
    /// 保存
    /// - Throws: 异常
    /// - Returns: 路径
    @discardableResult func setCache() throws -> String? {

        let path: String = T.getFilePath()
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try FileManager.default.createDirectoryIfNoExist(Element.directoryPath)
            try data.write(to: URL(fileURLWithPath: path))
        } catch {
            throw error
        }
        return path
    }

    
    /// 获取
    /// - Throws: 异常
    /// - Returns: 实例
    static func getCache() throws -> T? {
        
        var result: T? = nil
        let path: String = T.getFilePath()
        let decoder = JSONDecoder()
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: path))
            result = try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
        return result
    }
    
    
    /// 路径
    /// - Returns: 路径
    static func getFilePath() -> String {
        return Element.directoryPath + "/" + Element.fileName + "_array"
    }
    
}






extension FileManager {
    
    func createDirectoryIfNoExist(_ path: String) throws {
        
        var ocBool = ObjCBool(true)
        let exist = fileExists(atPath: path, isDirectory: &ocBool)
        
        if exist == false {
            do {
                try createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw error
            }
        }
    }
}


