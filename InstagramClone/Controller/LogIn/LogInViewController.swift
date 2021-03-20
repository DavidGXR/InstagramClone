//
//  LogInVC.swift
//  InstagramClone
//
//  Created by David Im on 6/10/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit
import Firebase

final class LogInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!

    private let db = Firestore.firestore()
    @objc private let logIn = LogIn()
    private let alert = AlertDialog()
    private var errorToken: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        errorToken?.invalidate()
    }
    
    
    @IBAction func logInBtn(_ sender: UIButton) {
        passwordTextField.resignFirstResponder()
        if let email = emailTextField.text, let password = passwordTextField.text{
            alert.startActivityIndicatorOverlayView(view: self.view, color: .white)
            logIn.logIn(email: email, password: password)
        }
    }
    
    @IBAction func signupBtn(_ sender: UIButton) {
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpVC = signUpStoryboard.instantiateViewController(withIdentifier: "signUpVC") as! SignUpViewController
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    private func setupViews() {
        logInBtn.layer.cornerRadius = logInBtn.frame.height/5
        emailTextField.delegate     = self
        passwordTextField.delegate  = self
        logInBtn.isUserInteractionEnabled = false
        logInBtn.alpha = 0.5
        loginTextFieldEditingChanged()
        listenForLogInError()
        logIn.checkIfLogIn() // check if user has logged in before
    }
    
    //MARK: - Observe Errors from LogIn.swift
    private func listenForLogInError(){
        errorToken = observe(\LogInViewController.logIn.error, options:[.new]) { (self, change) in
            if let error = change.newValue {
                switch error{
            
                case C.errorEmail: self.alert.showInvalidEmailAlert(on: self)
                case C.errorPassword: self.alert.showInvalidPasswordAlert(on: self)
                case C.success:
                    let homeTabBar = self.storyboard?.instantiateViewController(withIdentifier: "homeTabBar") as! HomeTabBarController
                    homeTabBar.modalPresentationStyle = .fullScreen
                    DispatchQueue.main.async {
                        self.present(homeTabBar, animated: true, completion: nil)
                    }
                    self.alert.stopActivityIndicatorOverlayView()
                default: self.alert.showInvalidDataAlert(on: self)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
}

//MARK: - TextField Validation
extension LogInViewController{
        
    private func loginTextFieldEditingChanged() {
        emailTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                 for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                 for: .editingChanged)
    }
    
    @objc private func textFieldsIsNotEmpty() {
         guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty
         else{
            logInBtn.isUserInteractionEnabled = false
            logInBtn.alpha = 0.5
            return
         }
         logInBtn.isUserInteractionEnabled = true
         logInBtn.alpha = 1
    }
}


