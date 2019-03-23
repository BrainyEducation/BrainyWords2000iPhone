//
//  Utility.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 9/29/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class Utility: NSObject {

    static let shared = Utility()
    
    var interiorItems : [StreetItemModel] = []
    var streetItems : [StreetItemModel] = []
    var jsonItemObjects : JSON!
    
    var praiseSounds:[String] = []
    var correctSoundIndex = -1
    
    let fileManager = FileManager.default



    
    
    //sprint 4 quiz
    var listSpecialPath : [String] = []
    override init() {
        super.init()
        
        let urlJson = self.getJsonURL(withName: "interior", from: Utility.Layouts.jsonData)
        if let stringJson = self.getContentString(fromUrl: urlJson) {
            if let data =  Mapper<StreetItemModel>().mapArray(JSONString: stringJson){
                interiorItems = data
                
            }
        }
        
        let streetJSON = self.getJsonURL(withName: "data", from: Utility.Layouts.jsonData)
        if let stringJson = self.getContentString(fromUrl: streetJSON) {
            if let data =  Mapper<StreetItemModel>().mapArray(JSONString: stringJson){
                streetItems = data
            }
        }
        

        
        // sprint 4 quiz
        let path = fileManager.documentPath(name: "Scores.plist")
        if !fileManager.isExsist(at: path){
            guard let bundlePath = Bundle.main.path(forResource: "Scores", ofType: "plist") else { return }
            let _ = fileManager.copy(from: bundlePath, to: path)
        }
        getListSpecialPath()

        let itemJson = self.getJsonURL(withName: "displayitems", from: Utility.Layouts.jsonData)
        if let jsonData = getContentData(fromUrl: itemJson) {
            if let jsonItem = getJsonData(fromData: jsonData) {
               jsonItemObjects = jsonItem
            }
        }
        
        if let content = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent("Quiz_Sounds/correct")){
            praiseSounds = content
        }

    }
    
    static var bundleURL: URL{
        return Bundle.main.resourceURL!
    }
    

    static var drawable : URL {
        return Utility.bundleURL.appendingPathComponent("drawable")
    }
    
    static func getContents(fromURL url: URL) -> [String]?{
        return FileManager.default.getContents(from: url.path)
    }
    
    static func getURL(withName name: String, from url: URL) -> URL{
        return url.appendingPathComponent(name)
    }
    
    static func getAudioURL(withName name: String, from url: URL) -> URL{
        return url.appendingPathComponent(name+".mp3")
    }
    
    static func getImageURL(withName name: String? = nil, from url: URL) -> URL{
            if let data = name {
                if data.contains(".png") {
                return url.appendingPathComponent((name ?? ""))
            }
        }
        return url.appendingPathComponent((name ?? "")+".png")
    }
    
    static func getLayoutURL(withName name: String? = nil, from url: URL) -> URL{
        return url.appendingPathComponent((name ?? "")+".xml")
    }
    
    func getJsonURL(withName name: String, from url: URL) -> URL {
        return url.appendingPathComponent(name+".json")
    }
    
    func getContentString(fromUrl: URL) -> String? {
        do {
            let conttent = try String.init(contentsOf: fromUrl)
            return conttent
        }
        catch{
            print("Can't get string content of file")
            return nil
        }
    }
    
    func getContentData(fromUrl: URL) -> Data? {
        do {
            let conttent = try Data(contentsOf: fromUrl)
            return conttent
        }
        catch{
            print("Can't get string content of file")
            return nil
        }
    }
    
    func getJsonData(fromData:Data) -> JSON? {
        do {
            let json = try JSON(data: fromData)
            return json
        }
        catch {
            print("Can't get json content")
            return nil
        }
    }
    
    func getPraiseSoundCorect() -> String{
        if correctSoundIndex == praiseSounds.count-1 {
            correctSoundIndex = -1
        }
        correctSoundIndex+=1
        return praiseSounds[correctSoundIndex]
    }
    
    

    
    struct Layouts {
        static var root: URL {
            return Utility.bundleURL.appendingPathComponent("layouts")
        }
        
        static var interiorLayouts: URL {
            return self.root.appendingPathComponent("interior-layouts")
        }
        
        static var mainLayouts: URL {
            return self.root.appendingPathComponent("main-layouts")
        }
        
        static var streetLayouts: URL {
            return self.root.appendingPathComponent("street-layouts")
        }
        
        static var jsonData: URL {
            return self.root.appendingPathComponent("json-data")
        }
        
    }
    
    struct assets {
        static var root: URL {
            return Utility.bundleURL.appendingPathComponent("assets")
        }
        
        static var xtra: URL {
            return self.root.appendingPathComponent("xtra")
        }
        
        static var headings: URL {
            return self.xtra.appendingPathComponent("HEADINGS")
        }
        
        static var invisible: URL {
            return self.xtra.appendingPathComponent("invisible")
        }
        
        static var quizSound:URL {
            return self.root.appendingPathComponent("Quiz_Sounds")
        }
        
        static var correct: URL {
            return self.quizSound.appendingPathComponent("correct")
        }
    }
    
    
    static func perform(after delay: TimeInterval, completionHandler: (() -> ())?){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            completionHandler?()
        }
        
    }
    
    
    // sprint 4 quiz
    func readScores(key: String) -> Double?{
        let path = fileManager.documentPath(name: "Scores.plist")
        
        guard let dic = NSDictionary(contentsOfFile: path) else{
            return nil
        }
        
        return dic.value(forKey: key) as? Double
        
    }
    
    func writeScores(key: String, value: Double){
        let path = fileManager.documentPath(name: "Scores.plist")
        //print(path)
        guard let dic = NSMutableDictionary(contentsOfFile: path) else{
            return
        }
        
        dic[key] = value
        dic.write(toFile: path, atomically: true)
    }
    
    func addScores(key: String, value: Double=1){
        let path = fileManager.documentPath(name: "Scores.plist")
        //print(path)
        guard let dic = NSMutableDictionary(contentsOfFile: path) else{
            return
        }
        
        let scores = self.readScores(key: key) ?? 0
        dic[key] = scores+value
        dic.write(toFile: path, atomically: true)
        NotificationCenter.default.post(name: NSNotification.Name.init("didAddCoin"), object: nil)
    }
    
    func getListSpecialPath(){
        for topic in streetItems{
            for cagory in topic.listInfoButton {
                if cagory.typeAction == 1 {
                    listSpecialPath.append(cagory.tag)
                }
            }
        }
        
        for topic in interiorItems{
            for cagory in topic.listInfoButton {
                if cagory.typeAction == 1 {
                  listSpecialPath.append(cagory.tag)
                }
            }
        }
    }
}
