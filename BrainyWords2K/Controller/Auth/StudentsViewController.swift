//
//  StudentsViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 2/27/19.
//  Copyright © 2019 HMD Avengers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class StudentsViewController: RootViewController {

    @IBOutlet weak var viewFormAdd: UIView!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var viewFormYPosition: NSLayoutConstraint!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var lbSuccess: UIView!
    
    var students = [StudentDataResponse]()
    
    var isEnableCreateBtn:Bool = false{
        didSet{
            createBtn.isUserInteractionEnabled = isEnableCreateBtn
            if isEnableCreateBtn{
                createBtn.alpha = 1
            }else{
                createBtn.alpha = 0.4
            }
        }
    }
    
    
    
    override func setDataWhenFirstLoad() {
        loadingView.startAnimating()
        Network.shared.fetchStudents { (studentData) in
            if let students = studentData {
                self.students = students
                self.loadingView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    override func setViewWhenDidLoad() {
        txtID.delegate = self
        tableView.initialize(delegate: self)
        viewFormAdd.alpha = 0
        lbSuccess.alpha = 0
        isEnableCreateBtn = false
        Network.shared.fetchStudents { (response) in
            guard let response = response else { return }
            self.students = response
            self.tableView.reloadData()
        }
    }
    
    func checkCorrect(){
        //&& !txtName.text!.trimmingWhitespace().isEmpty
        if txtID.text!.length  == 3  {
            isEnableCreateBtn = true
        }else{
            isEnableCreateBtn = false
        }
    }
    
    func showSuccess(){
        UIView.animate(withDuration: 0.2, animations: {
            self.lbSuccess.alpha = 1
        }) { (isDone) in
            UIView.animate(withDuration: 2, animations: {
                self.lbSuccess.alpha = 0
            })
        }
    }

    
    @IBAction func txtIDInputing(_ sender: UITextField) {
       checkCorrect()
    }
    
    @IBAction func txtNameInputing(_ sender: UITextField) {
       // checkCorrect()
    }
    
    
    func showViewForm(){
        UIView.animate(withDuration: 0.2, animations: {
            self.viewPopup.alpha = 0

        }, completion: { (bool) in
            UIView.animate(withDuration: 0.3, animations: {
                 self.viewFormAdd.alpha = 1
            })
        })
        
        
    }
    func hideViewForm(){
        UIView.animate(withDuration: 0.5, animations: {
            self.viewPopup.alpha = 1
           
            self.viewFormAdd.alpha = 0
        }, completion: nil)
        txtName.text = ""
        txtID.text = ""
        isEnableCreateBtn = false
    }
    
    
    
    
    
    @IBAction func addNewAction(_ sender: Any) {
        showViewForm()
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.dismissKeyboard()
        showLoading()
        Network.shared.addNewStudent(studentID: txtID.text!) { (response) in
            self.hideLoading()
            if let responseData = response {
                if responseData.statusResponse != "ok" {
                     RootAlert.sharedInstance.showInfo(message: responseData.message, title: "Message", success: nil)
                }
                
                guard let newStudent = responseData.data else{return}
                self.students.append(newStudent)
                self.tableView.reloadData()
                self.showSuccess()
                self.hideViewForm()
                
            }
        }
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        hideViewForm()
        self.dismissKeyboard()
    }
    
    
    @IBAction func backBtn(){
        popVC()
        RootConstants.token = nil
        RootConstants.student_id = nil
        RootConstants.teacher_id = nil
        RootConstants.teacher_id_long = nil
    }
}

// MARK: - UITableViewDataSource
extension StudentsViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = "Student "+students[indexPath.row].student_id
        cell?.textLabel?.font = UIFont(name: "Comic Sans MS", size: 15)
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension StudentsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idStudent = students[indexPath.row].student_id
    
        if let idTeacher = RootConstants.teacher_id, idStudent.isEmpty == false{
            let idRequest = idTeacher + idStudent
            self.showLoading()
            Network.shared.studentLogin(id: idRequest) { (stuResponse) in
                self.hideLoading()
                guard let studentData = stuResponse else {return}
                if studentData.statusResponse != "ok" {
                    RootAlert.sharedInstance.showInfo(message: studentData.message, title: "Message", success: nil)
                    return
                }
                RootConstants.student_id = studentData.data?.id
                
                
                let vc = RootLinker.getViewController(storyboard: RootStoryboard.StreetView, aClass: StreetViewController.self)
                self.pushVC(vc: vc)
//                if let rootView = RootLinker.sharedInstance.rootViewDeckController {
//                    rootView.centerViewController = RootLinker.getRootViewController(storyboard: .StreetView, aClass: StreetViewNavigationController.self)
//                }
                
            }
        }
        
        
    }
}

extension StudentsViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count - range.length + string.count <= 3
    }
}
