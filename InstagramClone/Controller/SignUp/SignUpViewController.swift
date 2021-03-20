//
//  SignUpVC.swift
//  InstagramClone
//
//  Created by David Im on 6/11/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class SignUpViewController: UIViewController{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var fullnameErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    private let db = Firestore.firestore()
    @objc private let signUp = SignUp()
    private let alert = TextFieldUtils()
    
    private var usernameCheck:NSKeyValueObservation?
    private var emailCheck:NSKeyValueObservation?
    private var signUpError:NSKeyValueObservation?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookBtn.layer.cornerRadius = facebookBtn.frame.height/5
        signupBtn.layer.cornerRadius = signupBtn.frame.height/5
        
        delegateTextField()
        emptyTextFieldCheck()
        validateSignUpTextField()
        alert.hideErrorLabel(emailErrorLabel: emailErrorLabel, passwordErrorLabel: passwordErrorLabel, fullnameErrorLabel: fullnameErrorLabel, usernameErrorLabel: usernameErrorLabel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        usernameCheck?.invalidate()
        emailCheck?.invalidate()
    }
    
    @IBAction func logInBtn(_ sender: UIButton) {
         let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
         let logInVC = mainStoryBoard.instantiateViewController(withIdentifier: C.logInVC) as! LogInViewController
         logInVC.modalPresentationStyle = .fullScreen
         present(logInVC, animated: true, completion: nil)
    }

    @IBAction func facebookLogin(_ sender: UIButton) {
        let webView = WKWebView(frame: CGRect(x: 0, y: 45, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let url = URL(string: "https://www.facebook.com")
        webView.load(URLRequest(url: url!))
        self.view.addSubview(webView)
        /*Cannot go back to SignUpVC*/
    }

    @IBAction func signUpBtn(_ sender: UIButton) {
        alert.startActivityIndicatorOverlayView(view: self.view, color: .white)
        if let email = emailTextField.text, let fullname = fullNameTextField.text, let username = userNameTextField.text, let password = passwordTextField.text {
                
            signUp.signUp(email: email, fullname: fullname, username: username, password: password)
            
            emailCheck = observe(\SignUpViewController.signUp.signUpError, options: [.new]) { (self, signUpError) in
                if let signUpError = signUpError.newValue{
                    if signUpError == C.emailExist{
                        self.alert.errorTextField(txtField: self.emailTextField, errorLabel: self.emailErrorLabel, errorText: "Email already exists", disableButton: self.signupBtn)
                        self.alert.stopActivityIndicatorOverlayView()
                    }else if signUpError == C.success{
                        // move to HomeVC
                        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        let homeTabBar = mainStoryBoard.instantiateViewController(withIdentifier: "homeTabBar") as! HomeTabBarController
                        homeTabBar.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.present(homeTabBar, animated: true, completion: nil)
                        }
                        
                        self.alert.stopActivityIndicatorOverlayView()
                    }else if signUpError == C.usernameExist{
                        self.alert.errorTextField(txtField: self.userNameTextField, errorLabel: self.usernameErrorLabel, errorText: "Username already exists", disableButton: self.signupBtn)
                        self.alert.stopActivityIndicatorOverlayView()
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}// End of class


//MARK: - TextField Validation and Delegate's Methods
extension SignUpViewController: UITextFieldDelegate{
    
    private func validateSignUpTextField(){
        emailTextField.addTarget(self, action: #selector(emptyTextFieldCheck), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(emptyTextFieldCheck), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(emptyTextFieldCheck), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(emptyTextFieldCheck), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(checkEmail), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(checkFullName), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkPassword), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(checkUsername), for: .editingChanged)
    }
    
    @objc private func emptyTextFieldCheck() {
        guard let fullName = fullNameTextField.text, !fullName.isEmpty, let email = emailTextField.text, !email.isEmpty, let username = userNameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signupBtn.isUserInteractionEnabled = false
            signupBtn.alpha = 0.5
            return
        }
        signupBtn.isUserInteractionEnabled = true
        signupBtn.alpha = 1
    }
    
    @objc private func checkUsername(){
        alert.startActivityIndicatorOnTextField(for: userNameTextField)
        signUp.checkUsername()
        
        usernameCheck = observe(\SignUpViewController.signUp.usernameError, options: [.new]) { (self, change) in
            if let username = self.userNameTextField.text, let usernameFromDb = change.newValue{
                if username == usernameFromDb{
                    self.alert.errorTextField(txtField: self.userNameTextField, errorLabel: self.usernameErrorLabel, errorText: "Username already exist", disableButton: self.signupBtn)
                    self.alert.stopActivityIndicator()
                }else if username != usernameFromDb && !username.isEmpty{
                    self.alert.correctTextField(txtFieldCorrect: self.userNameTextField, hideLabel: self.usernameErrorLabel, enableButton: self.signupBtn)
                    self.alert.stopActivityIndicator()
                }else if username.isEmpty {
                    self.alert.emptyTextField(txtFieldClear: self.userNameTextField, clearLabel: self.usernameErrorLabel, disableButton: self.signupBtn)
                    self.alert.stopActivityIndicator()
                }
            }
        }
    }
    
    @objc private func checkFullName(){
        if let fullname = fullNameTextField.text{
            if signUp.checkFullname(fullnameTextField: self.fullNameTextField) == true {
                alert.correctTextField(txtFieldCorrect: fullNameTextField, hideLabel: fullnameErrorLabel, enableButton: signupBtn)
            }else if fullname.isEmpty{
                alert.emptyTextField(txtFieldClear: fullNameTextField, clearLabel: fullnameErrorLabel, disableButton: signupBtn)
            }else{
                alert.errorTextField(txtField: fullNameTextField, errorLabel: fullnameErrorLabel, errorText: "Fullname must contain only letters", disableButton: signupBtn)
            }
        }
    }

    @objc private func checkPassword(){
        if let password = passwordTextField.text{
            if password.count < 8 && password.count != 0 {
                alert.errorTextField(txtField: passwordTextField, errorLabel: passwordErrorLabel, errorText: "Password must contain at least 8 letters", disableButton: signupBtn)
           }else if password.count == 0 {
                alert.emptyTextField(txtFieldClear: passwordTextField, clearLabel: passwordErrorLabel, disableButton: signupBtn)
            }else{
                alert.correctTextField(txtFieldCorrect: passwordTextField, hideLabel: passwordErrorLabel, enableButton: signupBtn)
            }
        }
    }
    
    @objc private func checkEmail(){
        if let email = emailTextField.text{
            if signUp.validateEmail(emailTextField: self.emailTextField) == true{
                alert.correctTextField(txtFieldCorrect: emailTextField, hideLabel: emailErrorLabel, enableButton: signupBtn)
            }else if signUp.validateEmail(emailTextField: self.emailTextField) == false && email.count != 0{
                alert.errorTextField(txtField: emailTextField, errorLabel: emailErrorLabel, errorText: "Email is badly formatted", disableButton: signupBtn)
            }else if email.count == 0{
                alert.emptyTextField(txtFieldClear: emailTextField, clearLabel: emailErrorLabel, disableButton: signupBtn)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case self.emailTextField: passwordTextField.becomeFirstResponder()
        case self.passwordTextField: fullNameTextField.becomeFirstResponder()
        case self.fullNameTextField: userNameTextField.becomeFirstResponder()
        default: view.endEditing(true)
        }
        return true
    }
    
    func delegateTextField(){
        emailTextField.delegate                 = self
        fullNameTextField.delegate              = self
        passwordTextField.delegate              = self
        userNameTextField.delegate              = self
        
        emailTextField.autocorrectionType       = .no
        fullNameTextField.autocorrectionType    = .no
        passwordTextField.autocorrectionType    = .no
        userNameTextField.autocorrectionType    = .no
    }
}
