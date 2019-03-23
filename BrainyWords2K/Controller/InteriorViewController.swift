//
//  InteriorViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 9/30/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit
import SWXMLHash
//import SnapKit
import ObjectMapper

enum InteriorViewDef :Int {
    case toys
    case bakery
    case job
    case vehicles
    case sports
    case clothing
    case groceries
    case music
    case hairSalon
    case tools
    case birds
    case water
    case dinosaur
    case meat
    case monkey
    case reptiles
    case plant
    case zoo
    case nursery
    case farmAnimal
    case school
    case healthMedial
    case things
    case people
    case pediatrician
    case building4a
    case building4b
    case building4c
    case park
    case building7a
    case house
    case building11a
    case playground
}

class InteriorViewController: RootViewController {

    var imgBackground: UIImage?

    var intergory : StreetItemModel?
    var tagButton : String = ""
    @IBOutlet  weak var collectionView : UICollectionView!
    @IBOutlet private weak var constraintBottom: NSLayoutConstraint!
    @IBOutlet private weak var bottomView: UIStackView!
    @IBOutlet private weak var viewButtonHome: UIView!
    @IBOutlet private weak var viewButtonList: UIView!
    var heightCell : CGFloat = 0
    var widthCell : CGFloat = 0
    //for testing
    var idTagBtn:Int?
    override func setDataWhenFirstLoad() {

        viewButtonHome.isHidden = true
        viewButtonList.isHidden = true
        
        getDataInterrior()
        getImage()
        
       
    }
    
    override func setViewWhenDidLoad() {
        
        setupCollection()
        
    }
    
    @IBAction func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func homePressed(){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func displayStorePressed(){
        
        
        let indexData = getIndexDataInterrior()
        if let type = InteriorViewDef(rawValue: indexData){
            switch type {
            case .building4a, .building4b, .building4c,
                 .park:
                let interior = RootLinker.getViewController(storyboard: .Inside, aClass: InteriorViewController.self) as! InteriorViewController
                interior.tagButton = "park"
                
                self.present(interior, animated: true, completion: nil)
            case .building7a:
                let interior = RootLinker.getViewController(storyboard: .Inside, aClass: InteriorViewController.self) as! InteriorViewController
                interior.tagButton = "people"
                self.present(interior, animated: true, completion: nil)
            case .zoo, .birds, .dinosaur, .water, .reptiles, .meat, .plant, .monkey:
                let vc = RootLinker.getViewController(storyboard: .Inside, aClass: DisplayItemsViewController.self) as! DisplayItemsViewController
                vc.path = intergory?.listInfoButton.first?.tag ?? ""
                self.present(vc, animated: true, completion: nil)
            default: break
            }
            
            
        }
        
    }
    

}

//MARK: Ininializer
extension InteriorViewController {
    
    func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCellNib(cellClass: InteriorCell.self)

    }
    
    func getIndexDataInterrior() -> Int {
        if  tagButton.contains("toys") {
            return InteriorViewDef.toys.rawValue
        } else if  tagButton.contains("bakery") {
            return  InteriorViewDef.bakery.rawValue
        } else if  tagButton.contains("job") {
            return  InteriorViewDef.job.rawValue
        } else if  tagButton.contains("vehicle") {
            return  InteriorViewDef.vehicles.rawValue
        } else if  tagButton.contains("sports") {
            return  InteriorViewDef.sports.rawValue
        } else if  tagButton.contains("cloth") {
            return  InteriorViewDef.clothing.rawValue
        } else if  tagButton.contains("groceries") {
            return  InteriorViewDef.groceries.rawValue
        } else if  tagButton.contains("music") {
            return  InteriorViewDef.music.rawValue
        } else if  tagButton.contains("hair") {
            return  InteriorViewDef.hairSalon.rawValue
        } else if  tagButton.contains("tools") {
            return  InteriorViewDef.tools.rawValue
        } else if  tagButton.contains("zoo") {
            if  tagButton.contains("birds") {
                return  InteriorViewDef.birds.rawValue
            } else if  tagButton.contains("water") {
                return  InteriorViewDef.water.rawValue
            } else if  tagButton.contains("dino") {
                return  InteriorViewDef.dinosaur.rawValue
            } else if  tagButton.contains("meat") {
                return  InteriorViewDef.meat.rawValue
            } else if  tagButton.contains("monkey") {
                return  InteriorViewDef.monkey.rawValue
            } else if  tagButton.contains("reptiles") {
                return  InteriorViewDef.reptiles.rawValue
            } else if  tagButton.contains("plant") {
                return  InteriorViewDef.plant.rawValue
            } else {
                return  InteriorViewDef.zoo.rawValue
            }
        } else if  tagButton.contains("nursery") {
            return  InteriorViewDef.nursery.rawValue
        } else if  tagButton.contains("farm") {
            return  InteriorViewDef.farmAnimal.rawValue
        } else if  tagButton.contains("school") {
            return  InteriorViewDef.school.rawValue
        } else if tagButton.contains("playground")  {
            return InteriorViewDef.playground.rawValue
        } else if  tagButton.contains("health") {
            return  InteriorViewDef.healthMedial.rawValue
        } else if  tagButton.contains("things") {
            return  InteriorViewDef.things.rawValue
        } else if  tagButton.contains("people") {
            return  InteriorViewDef.people.rawValue
        } else if  tagButton.contains("pediatrician") {
            return  InteriorViewDef.pediatrician.rawValue
        } else if  tagButton.contains("park") {
            if tagButton == "park1" {
                return  InteriorViewDef.building4a.rawValue
            } else if tagButton == "park2" {
                return  InteriorViewDef.building4b.rawValue
            } else if tagButton == "park3" {
                return  InteriorViewDef.building4c.rawValue
            } else {
                return  InteriorViewDef.park.rawValue
            }
        } else if tagButton ==  "building7" {
            return  InteriorViewDef.building7a.rawValue
        } else if tagButton == "building11a"{
            return InteriorViewDef.building11a.rawValue
        }
        else {
            return  InteriorViewDef.house.rawValue
        }
    }
    
    func getDataInterrior() {
        if Utility.shared.interiorItems.count == 0 { return }
        
        let indexData = getIndexDataInterrior()
        if let type = InteriorViewDef(rawValue: indexData){
            switch type {
            case .building4a, .building4b, .building4c,
                 .building7a, .zoo, .building11a:
                self.updateLayout()
            default: break
            }
        }
        
        intergory = Utility.shared.interiorItems[indexData]
        
    }
    

    
    func updateLayout(){
        constraintBottom.constant = 64
        if #available(iOS 11.0, *) {
            constraintBottom.constant -= self.view.safeAreaInsets.bottom
        }
        viewButtonHome.isHidden = false
        viewButtonList.isHidden = false
    }

    
    func getImage(){
        guard let dataInter = intergory else { return }
        
        let urlImage = Utility.getImageURL(withName: dataInter.imageLink, from: Utility.drawable)
        guard let imgBackground = UIImage.init(contentsOfFile: urlImage.path) else {
            return
        }
        self.imgBackground = imgBackground
        
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        heightCell = UIScreen.height - constraintBottom.constant
        
        if #available(iOS 11.0, *) {
            heightCell -= self.view.safeAreaInsets.bottom
        }
        if let sizeImg = self.imgBackground?.size {
            widthCell =  heightCell*sizeImg.width/sizeImg.height
            layout.itemSize = CGSize(width:widthCell, height: heightCell)
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}

//MARK:Action
extension InteriorViewController {
    
    func selectButtonItem(clickPoint:CGPoint) -> ButtonItemModel?{
        if let dataInter = intergory {
            for button in dataInter.listInfoButton {
                if button.percentStartX <= clickPoint.x && clickPoint.x <= button.percentEndX && button.percentStartY <= clickPoint.y && clickPoint.y <= button.percentEndY{
                    return button
                }
            }
        }
        return nil
    }
    

    
}

extension InteriorViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: InteriorCell.self, for: indexPath) as! InteriorCell
        cell.imageView.image = imgBackground
        cell.delegate = self
        cell.imageView.contentMode = .scaleToFill
       
        if let image = imgBackground {
            let height = UIScreen.height - constraintBottom.constant
            cell.set(width: height*image.size.width / image.size.height)
        }
        
        if RootStyleManager.sharedInstance.isTesting {
            if let data = intergory{
                 testAreaItem(listItem: data.listInfoButton, width: widthCell, height: heightCell, viewAdd: cell.imageView)

            }
           
        }
        
        return cell
    }
    
    

}

extension InteriorViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let indexData = getIndexDataInterrior()
        if let type = InteriorViewDef(rawValue: indexData){
            switch type {
            case .building4a, .building4b, .building4c, .building7a, .building11a:
                if #available(iOS 11.0, *) {
                    return UIEdgeInsetsMake(0, -self.view.safeAreaInsets.left, 0, -self.view.safeAreaInsets.right)
                }
                return .zero
            default: break
            }
        }
            
        let height = UIScreen.height - constraintBottom.constant
        let width = height*imgBackground!.size.width/imgBackground!.size.height
        
        let totalCellWidth = width
        let totalSpacingWidth:CGFloat = 0
        
        let leftInset = (collectionView.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
    func addAreaToTestItem(cell:StreetViewItemCell,button:ButtonItemModel){
        if let tagViewJustSelect = idTagBtn {
            if let subview = cell.contentView.viewWithTag(tagViewJustSelect) {
                subview.removeFromSuperview()
            }
        }
        
        let selectView = getViewFromButton(item: button, width: widthCell, height: heightCell)
        selectView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        selectView.tag = button.id
        idTagBtn = button.id
        cell.imageView.addSubview(selectView)
    }
}

extension InteriorViewController : StreetViewItemCellDelegate {
    func touchOnScreen(_ touches: Set<UITouch>, with event: UIEvent?, cell: StreetViewItemCell) {
        let touch = touches.first
        guard let location = touch?.location(in: cell.imageView) else {return}
    
        let percentPonit = changePointToPercentPoint(point: location, width: cell.width, height: cell.height)
        guard let button = selectButtonItem(clickPoint: percentPonit) else {return}
        
       if RootStyleManager.sharedInstance.isTesting{
        addAreaToTestItem(cell: cell, button: button)
        }

        guard let typeButton = typeActionOfButton.init(rawValue: button.typeAction) else{return}
      
        switch typeButton {
        case .playSound:
            let urlSound = Utility.getURL(withName: button.tag, from: Utility.assets.root)
            RootAudioPlayer.shared.playSound(from: urlSound)
        case .openStore:
            var tag = button.tag
            
            if tag == "Vehicles/fun"{
                tag = tag.replace(target: "/", withString: "_")
            } else if tag == "Mall/hair_salon/boys" {
                tag = "hair_boys"
            } else if tag == "Mall/hair_salon/girls"{
                tag = "hair_girls"
            }
            
            guard let seperateTag = tag.components(separatedBy: "/").last
                else{
                return
            }
            
            let namesound = "00\(seperateTag)"
            RootAudioPlayer.shared.url = Utility.getAudioURL(withName: namesound, from: Utility.assets.headings)

            let duration = RootAudioPlayer.shared.duration
            RootAudioPlayer.shared.play()
            
            Utility.perform(after: duration) {
                let vc = RootLinker.getViewController(storyboard: .Inside, aClass: DisplayItemsViewController.self) as! DisplayItemsViewController
                if tag == "Health/psychologist"{
                    button.tag = "Health/feelings"
                }
                
                vc.path = button.tag
                self.present(vc, animated: true, completion: nil)
            }
            
        case .openInterior:
        
            var tag = button.tag
            
            if (tag.contains("zoo")) {
                if (tag.contains("water")) {
                    tag = "aquatic_water_animals";
                } else if (tag.contains("dino")) {
                    tag = "dinosaurs";
                } else if (tag.contains("meat")) {
                    tag = "carnivore_meat_eaters";
                } else if (tag.contains("reptiles")) {
                    tag = "reptiles";
                } else if (tag.contains("plant")) {
                    tag = "herbivore_plant_eaters";
                } else if (tag.contains("monkeys")) {
                    tag = "monkeys_and_apes";
                } else if (tag.contains("birds")) {
                    tag = "birds_for_zoo_only";
                }
            }
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
    

}


