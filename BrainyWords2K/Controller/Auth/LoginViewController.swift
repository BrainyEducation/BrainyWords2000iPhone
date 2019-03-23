//
//  LoginViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 2/27/19.
//  Copyright © 2019 HMD Avengers. All rights reserved.
//

import UIKit
import SwiftValidator

class LoginViewController: RootViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var lblErrorEmail: UILabel!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet private weak var lblErrorPassword: UILabel!
    
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var btnView: UIView!
    
    
    let validator = Validator()
    
    override func setDataWhenFirstLoad() {
        
    }
    
    override func setViewWhenDidLoad() {
        setupPopupView()
        btnRemove.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtEmail.text = ""
        txtPassword.text = ""
    }
    
    func setupPopupView(){
        popUpView.alpha = 0
        txtEmail.keyboardType = .emailAddress
        txtEmail.placeholder = "Email"
        validator.registerField(txtEmail, errorLabel: lblErrorEmail, rules: [RequiredRule(), EmailRule()])
        
        txtPassword.placeholder = "Password"
        txtPassword.isSecureTextEntry = true
        validator.registerField(txtPassword, errorLabel: lblErrorPassword, rules: [RequiredRule(), MinLengthRule(length: 6)])
        
        resetForm()
    }
    
    func resetForm(){
        lblErrorEmail.isHidden = true
        lblErrorPassword.isHidden = true
    }
    
    @IBAction func loginPressed(){
        resetForm()
        validator.validate(self)
    }
    
    @IBAction func teacherPopupAction(_ sender: Any) {
        showPopup()
    }
    
    @IBAction func removePopUpAction(_ sender: Any) {
        hidePopUp()
    }
    
    
    @IBAction func PlayGame(_ sender: Any) {
         let vc = RootLinker.getViewController(storyboard: .StreetView, aClass: StreetViewController.self)
            pushVC(vc: vc)
        
    }
    
    func showPopup(){
        popUpView.isHidden = false
        btnView.isHidden = true
        btnView.alpha = 0
        UIView.animate(withDuration: 0.7, animations: {
            self.popUpView.alpha = 1
   
        }, completion: nil)
        btnRemove.isHidden = false
    }
    
    func hidePopUp(){
         self.btnView.isHidden = false
        popUpView.isHidden = true
        self.popUpView.alpha = 0
         self.btnRemove.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.btnView.alpha = 1

        }) { (Bool) in
           
        }
    }
    
}

extension LoginViewController: ValidationDelegate{
    func validationSuccessful() {
        self.dismissKeyboard()
        self.showLoading()
        Network.shared.teacherLogin(email: txtEmail.text!, password: txtPassword.text!) { (response) in
            self.hideLoading()
            guard let response = response else { return }
            if response.status == "error" {
                RootAlert.sharedInstance.showInfo(message: response.message, title: "Message", success: nil)
                return
            }
            
            RootConstants.token = response.token
            RootConstants.teacher_id = response.data?.teacher_id
            RootConstants.teacher_id_long = response.data?.id
            
            let vc = RootLinker.getViewController(storyboard: .Auth, aClass: StudentsViewController.self)
            self.pushVC(vc: vc)
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for error in errors{
            error.1.errorLabel?.isHidden = false
            error.1.errorLabel?.text = error.1.errorMessage
        }
    }
}
