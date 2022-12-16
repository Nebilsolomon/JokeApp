//
//  MyNetStuff.swift
//  JokeApp
//
//  Created by Long Nguyen on 12/6/22.
//
import Foundation
import CryptoKit
import Foundation
import UIKit
class MyNetStuff
{
    static func loadData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ())
    {
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with:request)
        {
            (data, response, error) in
            OperationQueue.main.addOperation
            {
                completion(data, response, error)
            }
        }
        task.resume()
    }
}

class MyPersistence
{
    static func stringToHashString(_ s: String) -> String
    {
        let data = s.data(using: String.Encoding.utf8)!
        let hash = SHA512.hash(data: data)
        print("Hash is: \(hash)")
        
        let hasString = hash.map{
            String(format: "%02hhx", $0)
        }.joined()
        return hasString
    }
    
    func makeFileCacheURL(_ fileKey: String) -> URL{
        let cacheDirs = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let cacheDir = cacheDirs.first!
        let fileNameHash = MyPersistence.stringToHashString(fileKey)
        let cachePath = cacheDir.appendingPathComponent(fileNameHash)
        print("Cache URL for \"\(fileKey)\" is: \(cachePath)")
        return cachePath
    }
    func isFileInCache(fileKey: String)
    -> Bool
    {
        let cacheURL = self.makeFileCacheURL(fileKey)
        let exists = FileManager.default.fileExists(atPath: cacheURL.path)
        return exists
    }
    
    func saveFileToCache(fileKey: String, fileData: Data?, overwrite: Bool = false )
    {
        if let fileDataSafe = fileData
        {
            let cacheURL = self.makeFileCacheURL(fileKey)
            
            if (overwrite == false && self.isFileInCache(fileKey: fileKey))
            {
                print("File Exists and overwrite is false; Refusing to overwrite: \(fileKey)")
                return
            }
            do
            {
                try fileDataSafe.write(to: cacheURL, options: NSData.WritingOptions.atomic)
                print("successfully saved file \(fileKey) to cache")
            }
            catch
            {
                print("failed to save file \(fileKey) to cache: \(error)")
            }
        }
    }
    func loadFileFromCache(fileKey: String)-> Data?
    {
        let cacheURL = self.makeFileCacheURL(fileKey)
        
        do
        {
            let fileData = try Data(contentsOf: cacheURL)
            print("successfully loaded file \(fileKey) (\(fileData.count) bytes")
            return fileData
        }
        catch
        {
            print("Failed to load file \(fileKey) from cache: \(error)")
            return nil
        }
    }
    
    func loadFileToCache( urlAsString : String, completion: @escaping (Data) ->())
    {
        let fileURL = URL(string: urlAsString)!

        MyNetStuff.loadData(from: fileURL)
        {
            (data, response, error) in
            if let theError = error
            {
                print("Error loading file \(urlAsString): \(theError)")
            }
            else if (data != nil)
            {
                self.saveFileToCache(fileKey: urlAsString, fileData: data)
                OperationQueue.main.addOperation{
                    completion(data!)
                }
            }
            else
            {
                print ("Unknown error loading URL: \(urlAsString)")
            }
        }
    }
    func makeFileDocumentsURL(_ fileName: String)
    -> URL
    {
        let docDirs = FileManager.default.urls(
            for: FileManager.SearchPathDirectory.documentDirectory,
            
            in: FileManager.SearchPathDomainMask.userDomainMask)
        
        let docDir = docDirs.first!
        
        let fileInDocsURL = docDir.appendingPathComponent(fileName)
        
        print("Documents URL for \"\(fileName))\" is : \(fileInDocsURL)")
        
        return fileInDocsURL
    }
    func saveFileToUserFolder(fileName: String, data: Data?)
    {
        if let fileData = data {
            let fileURL = self.makeFileDocumentsURL(fileName)
            
            do {
                try fileData.write(to: fileURL, options: NSData.WritingOptions.atomic)
                print("Successfully saved file \"\(fileName)\" to local folder: \(fileURL)")
            }
            catch{
                print("Failed to save local file: \(fileURL)")
            }
            
        }
    }
    
    
}

class MyTimer
{
    private var StartTime: Double!
    private var stopTIme: Double!
    private var elapsedTime: Double!
    
    private var isRunning: Bool = true
    
    init()
    {
        self.StartTime = CACurrentMediaTime()
        self.stopTIme = self.StartTime
    }
    func stop ()
    {
        self.isRunning = false
        self.stopTIme = CACurrentMediaTime()
    }
    private func updateElapsedTime()
    {
        let tempStopTIme: Double = (
            self.isRunning ?
            CACurrentMediaTime(): self.stopTIme)
        self.elapsedTime = tempStopTIme - self.StartTime
    }
    
    func get() -> Double
    {
        self.updateElapsedTime()
        return self.elapsedTime
    }
}

