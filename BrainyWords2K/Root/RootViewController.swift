//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import ViewDeck

enum BarButtonPosition{
    case right
    case left
}

protocol RootProtocal: class
{
    func registerNotifications()
    func setDataWhenFirstLoad()
    func setViewWhenDidLoad()
}

class RootViewController : UIViewController, RootProtocal {
    
    var analyticsPageName : String = ""
    var analyticsPageNameBase : String {
        get {
            return ("\(type(of: self))")
        }
    }
    var analyticsPageId : String? = nil
    var isModal = false
    var link : String = ""
    var indicatorView: RootIndicatorView?
    var downloadBtn: UIBarButtonItem!

    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        registerNotifications()
        setDataWhenFirstLoad()
        setViewWhenDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        analyticsPageName = analyticsPageNameBase
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        trackScreenView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
    }
    
    func showMenuCustomAnimationAddition() {
        // View controllers can override this to provide an additional block of code for the animation block
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: Layout
    func iPad()->Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: Analytics tracking
    
    func trackScreenView() {
        
    }
    
    // MARK: Indicator loading
    // Support figuring out that the page is loading in the app.
    func addIndicatorLoading(blockUI: Bool? = false) {
        
    }
    
    // showloading
    func showLoading(){
        if indicatorView == nil{
            indicatorView = RootIndicatorView()
        }
        indicatorView!.show()
    }
    
    // hide loading
    func hideLoading() {
        if let indicatorView = indicatorView{
            indicatorView.dismiss()
            self.indicatorView = nil
        }
    }
    
    func removeNetworkIssueView() {
        if let view  = self.view.viewWithTag(789) {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0.0
            }, completion: { (hidden) in
                view.removeFromSuperview()
            })
        }
    }
    
    
    // MARK: Root Protocol
    func registerNotifications() {
        
    }
    
    func setDataWhenFirstLoad() {
        
    }
    
    func setViewWhenDidLoad() {
        
    }
    

    
    // MARK: Bar Button Item
    
    func addImageBarButton(position: BarButtonPosition, image: UIImage, target: Any, action: Selector){
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        if position == .left{
            self.navigationItem.leftBarButtonItem = barButton
        }else{
            self.navigationItem.rightBarButtonItem = barButton
        }
    }

    
    
    func addTitleBarButton(position: BarButtonPosition, title: String, target: Any, action: Selector){
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        barButton.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
     
        if position == .left{
            self.navigationItem.leftBarButtonItem = barButton
        }else{
            self.navigationItem.rightBarButtonItem = barButton
        }

    }
    
    func addImageBarButton(position: BarButtonPosition, image: UIImage, target: Any, action: Selector, isAdd: Bool? = false){
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
       
        if position == .left{
            if isAdd! {
                self.navigationItem.leftBarButtonItems?.append(barButton)
            }else {
                self.navigationItem.leftBarButtonItem = barButton
            }
        }else{
            if isAdd! {
                self.navigationItem.rightBarButtonItems?.append(barButton)
            }else {
                self.navigationItem.rightBarButtonItem = barButton
            }
        }
        
    }
    
    func addBackButton() {
        
        self.addImageBarButton(position: .left, image: #imageLiteral(resourceName: "ic_Back"), target: self, action: Selector(("backAction")))
    }
    
    
    func addMenuButton() {
        
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "menu"), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("menuAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addSearchButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "ic_Tabbar_Search"), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("searchAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addCloseButton() {
        let img = UIImage(named: "close")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: Selector(("closeAction")))
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
    }
    
    func addDoneButton() {
        let backButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector(("doneAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addEditButton() {
        let backButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: Selector(("editAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addCancelButton() {
        let backButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: Selector(("cancelAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addDeleteButton() {
        let backButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: Selector(("deleteAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addLoginButton(){
        let backButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: Selector(("loginAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addEmptyButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "emptyimage"), for: .normal)

        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

    }
    
 
    func addSaveButton(){
        let backButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: Selector(("saveAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addSendButton() {
        let backButton = UIBarButtonItem(title: "Send", style: .done, target: self, action: Selector(("sendAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func removeBarButtonItems() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func removeRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func printFonts() {
       let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }   
 
    }
    
    
    // hide title view of the navigation bar. it does not hide the nav totallly
    func hideNavigation(hide: Bool) {
    }
    
    func removeNavTotally() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func loadNavTotally() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func displayContentController(content: UIViewController, hostVC: UIViewController) {
        RootLinker.sharedInstance.rootNav?.addChildViewController(content)
        RootLinker.sharedInstance.rootNav?.view.addSubview(content.view)
        RootLinker.sharedInstance.rootNav?.didMove(toParentViewController: hostVC)
    }
    
    func hideContentController(content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
  
    
    func postNotification(name: Notification.Name){
        NotificationCenter.default.post(name: name, object: nil)
    }

    func addNotification(name: Notification.Name, actionHandler: ((Notification)->())?){
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { (noti) in
            actionHandler?(noti)
        }
    }
    
    func addNotification(name: Notification.Name, actionHandler: (()->())?){
        self.addNotification(name: name) { (noti) in
            actionHandler?()
        }
    }
}

// MARK: - Navigation
extension UIViewController {
    
    func openLeftNavigation() {
        if let rootViewDeck = RootLinker.sharedInstance.rootViewDeckController {
            rootViewDeck.open(.left, animated: true)
        }
    }
    
    func closeLeftNavigation() {
        if let rootViewDeck = RootLinker.sharedInstance.rootViewDeckController {
            rootViewDeck.open(.none, animated: true)
        }
    }

  
    
    func pushVC(vc: UIViewController, animation: RootNavigationPushAnimation? = nil){
        
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        // push view
        let animated = animation ?? RootNavigationPushAnimation.Default
        switch animated {
        case RootNavigationPushAnimation.Default:
            rootNav?.pushViewController(vc, animated: true)
        case RootNavigationPushAnimation.BottomTop:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
    }
    
   
    
    func popVCToRoot() {
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        rootNav?.popToRootViewController(animated: true)
        
    }
    

    
    func popVC(animation: RootNavigationPushAnimation? = nil) {
        
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        
        // get root nav by storyboard and the nav name
        let animated = animation ?? RootNavigationPushAnimation.Default
        
        switch animated {
            
        case RootNavigationPushAnimation.Default:
            _ = rootNav?.popViewController(animated: true)
            
        case RootNavigationPushAnimation.BottomTop:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            transition.subtype = kCATransitionFromBottom
            navigationController?.view.layer.add(transition, forKey:kCATransition)
            let _ = navigationController?.popViewController(animated: false)
            
        default:
            break
        }
    }
    

    
}

extension RootViewController {
    func updateHeightTable(height: CGFloat, viewUpdate: UIView) {
        for constraint in self.view.constraints {
            if constraint.identifier == "tableviewBottom" {
                constraint.constant = height
            }
        }
        view.layoutIfNeeded()
    }
    
   
    
    //handle data tableview is empty
    func handleTableViewEmpty(countData: Int, tableView: UITableView){
        if countData == 0 {
            UIView.animate(withDuration: 0.7, animations: {
                tableView.backgroundView?.alpha = 1.0
            })
            
        }else {
            tableView.backgroundView?.alpha = 0.0
        }
    }
    
    //back playlist Alarm
    func addBackButtonPlaylist(icon: String? = "ic_Player_Close"){
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: icon!), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("backActionPlaylist")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    //save Alarm
    func addSaveAlarm(icon: String? = "ic_Save_Alarm"){
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: icon!), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("saveAlarmAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addTitleBarTwoLine(firstLine: String, secondLine: String){
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        
        //FIXME:
        
        let setStyleTitle = NSMutableAttributedString(string: firstLine + "\n" + secondLine)
        
        setStyleTitle.setStyleForText(String(firstLine).strippingHTML, size: 17, weight: .bold)
        
        setStyleTitle.setStyleForText(secondLine, size: 15, weight: .regular)
        setStyleTitle.setColorForText(secondLine, with: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1))
        label.attributedText = setStyleTitle
        
        self.navigationItem.titleView = label
    }
    
    func changePointToPercentPoint(point:CGPoint,width:CGFloat,height:CGFloat) -> CGPoint{
        let percentXClick = (point.x / width) * 100
        let percentYClick = (point.y / height) * 100
        return CGPoint(x: percentXClick, y: percentYClick)
    }
    
    func testAreaItem(listItem:[ButtonItemModel],width:CGFloat,height:CGFloat,viewAdd:UIView){
        for item in listItem {
            let view = getViewFromButton(item: item, width: width, height: height)
            view.borderWidth = 1.5
            view.borderColor = .random()
            viewAdd.addSubview(view)
        }
    }
    
    func getViewFromButton(item:ButtonItemModel,width:CGFloat,height:CGFloat) -> UIView {
        return UIView(frame: CGRect(x: item.percentStartX*width/100, y: item.percentStartY*height/100, width: (item.percentEndX-item.percentStartX)*width/100, height: (item.percentEndY-item.percentStartY)*height/100))
    }
  
}
