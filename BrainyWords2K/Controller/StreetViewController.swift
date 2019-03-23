//
//  StreetViewController.swift
//  BrainyWords2k
//
//  Created by mac on 11/2/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

enum typeActionOfButton :Int {
    case playSound
    case openStore
    case openInterior
}


class StreetViewController: RootViewController {
    var listImage : [UIImage] = []
    var listPosittonImage : [CGFloat] = [] //store position each image in parent view (minX)
    var listWidthOfImage : [CGFloat] = [] // store width each image
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var zoomView: UIView!
    @IBOutlet weak var streetView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    var currentPositionX : CGFloat = 0
    
    //for testing
    var idSelectView:Int?
   
    var tap: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }
    var wrapView =  UIView()
    
    override func setDataWhenFirstLoad() {
        setupImage()
        addImageToScrollview()
        setupScrollStreetView()
        
        tap.numberOfTapsRequired = 1
        streetView.addGestureRecognizer(tap)
        lbTitle.text = "Brainy Words 2000"
        
    }
    
    var heightOfStreetView : CGFloat {
        return UIScreen.main.bounds.height * 0.8 
    }


}

//MARK: Initialize
extension StreetViewController {
    func setupImage(){
        for item in Utility.shared.streetItems {
            let urlImage = Utility.getImageURL(withName: item.imageLink, from: Utility.drawable)
            if let image = UIImage(contentsOfFile: urlImage.path) {
                listImage.append(image)
            }
           
        }
         listImage.append(listImage[0])
        listImage.insert(listImage[listImage.count-2], at: 0)
        //add first image in last array to make croll infinitive
    }
    
    // add all image into wrapview and and add wrapview into streetview(scrollview)
    func addImageToScrollview(){
        
        for (index,image) in listImage.enumerated(){
            let imageView = UIImageView()
            imageView.image = image
            imageView.tag = index
            let widthOfImage = heightOfStreetView * image.size.width / image.size.height
            imageView.frame = CGRect(x: currentPositionX, y: 0, width: widthOfImage, height: heightOfStreetView)

            currentPositionX += widthOfImage
            listWidthOfImage.append(widthOfImage)
            listPosittonImage.append(currentPositionX)
            //func for testing object
            if RootStyleManager.sharedInstance.isTesting {
                testAreaItem(listItem: getlistButtonItemStreetView()[index].listInfoButton, width: widthOfImage, height: heightOfStreetView, viewAdd: imageView)
            }
           
            wrapView.addSubview(imageView)
        }
        wrapView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: currentPositionX, height: heightOfStreetView))
        streetView.contentSize = CGSize(width: currentPositionX, height: heightOfStreetView)
        streetView.addSubview(wrapView)
        streetView.setContentOffset(CGPoint(x: listWidthOfImage[listWidthOfImage.count-2], y: 0), animated: false)
    }
    
    func setupScrollStreetView(){
        streetView.delegate = self
        streetView.showsVerticalScrollIndicator = false
        streetView.showsHorizontalScrollIndicator = false
        streetView.bounces = false
        streetView.bouncesZoom = false
        streetView.minimumZoomScale = 1.0
        streetView.maximumZoomScale = 2.0
        streetView.decelerationRate = 1
    }
    

    
    func getlistButtonItemStreetView()->[StreetItemModel]{
        var listBtnItemModel = Utility.shared.streetItems
        listBtnItemModel.insert(Utility.shared.streetItems[Utility.shared.streetItems.count-1], at: 0)
        listBtnItemModel.append(Utility.shared.streetItems[0])
        return listBtnItemModel
    }
    
    @IBAction func backAction(){
        popVC()
    }
}

//MARK: Action
extension StreetViewController {
    //hande gesture tap on screen from user.
    @IBAction func handleTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: streetView)
        guard let button = getButtonItem(point: location) else {return}
        guard let typeButton = typeActionOfButton(rawValue: button.typeAction) else {print("Err: No action type include")
            return}
       
        var tag = button.tag
        
        if tag == "clothes" {
            tag = "Clothing"
        } else if tag == "Outdoors/beach/creatures" {
            tag = "beach_creatures"
        }
        
        switch typeButton {
        case .playSound:
            let urlSound = Utility.getURL(withName: tag, from: Utility.assets.root)
            RootAudioPlayer.shared.playSound(from: urlSound)
        case .openStore:
            
            let range = (tag as NSString).range(of: "/", options: .backwards)
            
            
            if range.location != NSNotFound{
                tag = tag.substringFrom(index: range.location+1)
            }
            
            RootAudioPlayer.shared.url = Utility.assets.headings.appendingPathComponent("00"+tag+".mp3")
            let duration = RootAudioPlayer.shared.duration
            RootAudioPlayer.shared.play()
            
            Utility.perform(after: duration) {
                let vc = RootLinker.getViewController(storyboard: .Inside, aClass: DisplayItemsViewController.self) as! DisplayItemsViewController
                vc.path = button.tag
                self.present(vc, animated: true, completion: nil)
            }
            
        case .openInterior:
            
            let namesound = "00\(tag)"
            
            RootAudioPlayer.shared.url = Utility.getAudioURL(withName: namesound, from: Utility.assets.headings)
            
            let duration = RootAudioPlayer.shared.duration
            RootAudioPlayer.shared.play()
            
            
            Utility.perform(after: duration) {
                let interior = RootLinker.getViewController(storyboard: .Inside, aClass: InteriorViewController.self) as! InteriorViewController
                interior.tagButton = button.tag
                self.present(interior, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    //get item Button from location when tap on screen
    func getButtonItem(point:CGPoint) -> ButtonItemModel?{
        for (index,width) in listPosittonImage.enumerated() {
            //get index of image from location
            if point.x < width*streetView.zoomScale {
                var newPoint = point
                if index != 0 { //if location no content in first image change location
                    newPoint.x = point.x - listPosittonImage[index - 1]*streetView.zoomScale
                    
                }
                //change ponit to percent
                let percentPoint = changePointToPercentPoint(point: newPoint, width: listWidthOfImage[index]*streetView.zoomScale, height: heightOfStreetView*streetView.zoomScale)
                
                
                
                guard let button = selectItemFromPoint(clickPoint: percentPoint, indexStreet: index) else {return nil}
                
                if RootStyleManager.sharedInstance.isTesting {
                    if let tagViewJustSelect = idSelectView {
                        if let subview = self.view.viewWithTag(tagViewJustSelect) {
                            subview.removeFromSuperview()
                        }
                    }
                    let selectView = getViewFromButton(item: button, width: listWidthOfImage[index], height: heightOfStreetView)
                    selectView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
                    selectView.tag = button.id
                    idSelectView = button.id
                    for subview in wrapView.subviews {
                        if subview.tag == index {
                            subview.addSubview(selectView)
                        }
                    }
                    
                }
                return button
            }
        }
        return nil
    }
    
    //get item button form percent point
    func selectItemFromPoint(clickPoint: CGPoint,indexStreet:Int) -> ButtonItemModel?{
        //Because the start view is the first image so each index minus 1 anh the fisrt image change to last index to become correct index
        var indexImg = indexStreet
        if indexImg == 0 {
            indexImg = 17
        }
        let listButton = Utility.shared.streetItems[(indexImg - 1) % Utility.shared.streetItems.count].listInfoButton
        for button in listButton {
            if button.percentStartX <= clickPoint.x && clickPoint.x <= button.percentEndX && button.percentStartY <= clickPoint.y && clickPoint.y <= button.percentEndY{
                return button
            }
        }
        return nil
    }
}

extension StreetViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return wrapView
    }
    
    //here to make infinitive croll view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPosition = scrollView.contentOffset.x
  
        if xPosition > listWidthOfImage[1] {
            // if croll to near end view change to start view
            if scrollView.contentOffset.x >= listPosittonImage[listPosittonImage.count - 2]*scrollView.zoomScale {
                scrollView.contentOffset = CGPoint(x: listWidthOfImage[listWidthOfImage.count-2], y: scrollView.contentOffset.y)
            }
        }
        else if xPosition < UIScreen.main.bounds.width{
            //if croll to start view change to end view and make animation to avoid view stop suddenly
                let xCroll = listPosittonImage[listPosittonImage.count-3]*scrollView.zoomScale+UIScreen.main.bounds.width
                scrollView.contentOffset = CGPoint(x: xCroll, y: scrollView.contentOffset.y)
           
        }
        
        
    }
}


