//
//  DisplayItemsViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/3/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class DisplayItemObject{
    var title: String = ""
    var imagePath: URL
    var soundPath: URL
    var focus_Item:String = ""
    
    init(title: String, imagePath: URL, soundPath: URL, focusItem:String) {
        self.title = title
        self.imagePath = imagePath
        self.soundPath = soundPath
        self.focus_Item = focusItem
    }
}

class DisplayItemsViewController: RootViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var path: String!
    var items = [DisplayItemObject]()
    var holdingItems = [DisplayItemObject]()
    override func setDataWhenFirstLoad() {

        let itemObjects = Utility.shared.jsonItemObjects[path]
        for index in 0..<itemObjects.count  {
            let rootPath = Utility.assets.root
            let titleItem = itemObjects[index]["title"].description.trim
            let itemFocus = itemObjects[index]["app_id"].string ?? "5c6af19ab9cc5e1f7c9439c2"
            let itemImagePath =  itemObjects[index]["imageUri"].description
            let itemImageUrl = rootPath.appendingPathComponent(itemImagePath)
            let itemSoundPath = rootPath.appendingPathComponent(path+"/sounds")
            
            guard let soundName = itemImagePath.components(separatedBy: "/").last else {return}
            let itemSoundUrl = itemSoundPath.appendingPathComponent(soundName.replace(target: ".png", withString: ".mp3"))
            let displayItem = DisplayItemObject(title: titleItem, imagePath: itemImageUrl, soundPath: itemSoundUrl, focusItem: itemFocus)
            items.append(displayItem)
        }
        holdingItems = items
//        guard let contents = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent(path)),
//        let soundContents = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent(path+"/sounds")) else{
//            return
//        }
//
//        let sorted = contents.sorted{ $0 < $1 }
//        let soundSorted = soundContents.sorted{ $0 < $1 }
//        for (idx, item) in sorted.enumerated(){
//            if item.contains(".png"){
//                var fileName = ""
//                fileName = item.replace(target: ".png", withString: "")
//                fileName = fileName.replace(target: ".jpeg", withString: "")
//                var title = ""
//                let spacingCharacterSet = CharacterSet(charactersIn: "_+=")
//                title = fileName.components(separatedBy: spacingCharacterSet).joined(separator: " ")
//                let numberCharacterSet = CharacterSet(charactersIn: "1234567890")
//                title = title.components(separatedBy: numberCharacterSet).joined(separator: "")
//                title = title.replace(target: "}", withString: "?")
//
//                let rootPath = Utility.assets.root.appendingPathComponent(path)
//                let displayItem = DisplayItemObject(title: title.trim, imagePath: rootPath.appendingPathComponent(fileName+".png"), soundPath: rootPath.appendingPathComponent("sounds/"+soundSorted[idx]))
//                print(displayItem)
//                items.append(displayItem)
//            }
//        }

    }
    
    override func setViewWhenDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.registerCellNib(cellClass: DisplayItemCell.self)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 220, height: collectionView.height-16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset.right = 16
        layout.sectionInset.left = 16
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

    @IBAction func backPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homePressed(){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quizPressed(){
        let vc = RootLinker.getViewController(storyboard: .Inside, aClass: QuizViewController.self) as! QuizViewController
        vc.items = self.items
        vc.holdingItems = self.holdingItems
        vc.specialPath = path
        if path.lowercased().contains("school"){
            
            
            
//            if path.contains("addition"){
//                vc.specialPath = path
//            }
//            
            if path.contains("letters"){
                
                let newPath = path+"/letters_quiz"
                guard let contents = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent(newPath)),
                    let soundContents = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent(newPath+"/sounds")) else{
                        return
                }
                
                var newItems = [DisplayItemObject]()
                let sorted = contents.sorted{ $0 < $1 }
                let soundSorted = soundContents.sorted{ $0 < $1 }
                for (idx, item) in sorted.enumerated(){
                    if item.contains(".png"){
                        var fileName = ""
                        fileName = item.replace(target: ".png", withString: "")
                        fileName = fileName.replace(target: ".jpeg", withString: "")
                        var title = ""
                        let spacingCharacterSet = CharacterSet(charactersIn: "_+=")
                        title = fileName.components(separatedBy: spacingCharacterSet).joined(separator: " ")
                        let numberCharacterSet = CharacterSet(charactersIn: "1234567890")
                        title = title.components(separatedBy: numberCharacterSet).joined(separator: "")
                        title = title.replace(target: "}", withString: "?")
                        
                        let rootPath = Utility.assets.root.appendingPathComponent(newPath)
                        let displayItem = DisplayItemObject(title: title.trim, imagePath: rootPath.appendingPathComponent(fileName+".png"), soundPath: rootPath.appendingPathComponent("sounds/"+soundSorted[idx]), focusItem: "letters")
                        
                        newItems.append(displayItem)
                    }
                }
                
                vc.items = newItems
            }
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

extension DisplayItemsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: DisplayItemCell.self, for: indexPath) as! DisplayItemCell
        let item = items[indexPath.row]
        cell.binding(title: item.title, imageName: item.imagePath.path)
        return cell
    }
}

extension DisplayItemsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        RootAudioPlayer.shared.playSound(from: item.soundPath)
    }
}
