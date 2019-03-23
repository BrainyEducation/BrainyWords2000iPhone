//
//  FileManagerExtension.swift
//  GoldenTime
//
//  Created by Nguyen on 2/15/17.
//  Copyright © 2017 CAN. All rights reserved.
//

import Foundation
import UIKit


public extension String{
    
    /*
     Add path component
     **/
    func stringByAppendingPathComponent(path: String) -> String{
        return self+"/"+path
    }
}

public extension FileManager{

    //
    // MARK: - Create
    /*
     create a folder at give path
     **/
    func createFolder(at path: String) -> Bool{
        do {
            try self.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    //
    // MARK: - Get
    func getContents(from path: String) -> [String]?{
        if let paths = try? self.contentsOfDirectory(atPath: path){
            return paths
        }
        
        return nil
    }
    
    /*
     get path in document directory
     **/
    func documentPath(name: String) -> String{
        let directory = self.directoryPathAt(directory: .documentDirectory)
        return directory.stringByAppendingPathComponent(path: name)
    }
    
    func libraryPath(to name: String) -> String{
        let directory = self.directoryPathAt(directory: .libraryDirectory)
        return directory.stringByAppendingPathComponent(path: name)
    }
    
    func directoryPathAt(directory: SearchPathDirectory) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)
        let directory = paths[0]
        return directory
    }
    
    //
    // MARK: Common
    func isExsist(at path: String)->Bool{
        var isDir : ObjCBool = false
        if self.fileExists(atPath: path, isDirectory: &isDir){
            if isDir.boolValue {
                // file exists and is a directory
                
            } else {
                // file exists and is not a directory
            }
            return true
        } else {
            // file does not exist
        }
        
        return false
    }
    
    /*
     copy
     **/
    func copy(from sourcePath: String, to destinationPath: String) -> Bool{
        do{
            try self.copyItem(atPath: sourcePath, toPath: destinationPath)
        }catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    

    

}

