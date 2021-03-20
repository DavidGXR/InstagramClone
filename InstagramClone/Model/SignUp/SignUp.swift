//
//  SignUp.swift
//  InstagramClone
//
//  Created by David Im on 6/13/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import Firebase

class SignUp:NSObject{
    
    @objc dynamic var usernameError:String?
    @objc dynamic var signUpError: String?
    private let db = Firestore.firestore()
        
    func signUp(email:String, fullname:String, username:String, password:String){
        if usernameError == username {
            self.signUpError = C.usernameExist
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let err = error{
                    self.signUpError = err.localizedDescription
                }else{
                    self.signUpError = C.success
                    let userID = Auth.auth().currentUser?.uid
                    self.db.collection(C.documentID).document(userID!).setData(["fullname" : fullname, "username": username])
                }
            }
        }
    }
    
    func checkUsername(){
        db.collection(C.documentID).getDocuments { (snapshot, error) in
            if let err = error{
                print(err.localizedDescription)
            }else{
                if let querySnapshot = snapshot?.documents{
                    for allData in querySnapshot{
                        let usernameData = allData.data()
                        if let usernameFromDb = usernameData[C.username] as? String{
                            self.usernameError = usernameFromDb
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Validate Email Format
    func validateEmail(emailTextField: UITextField) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z]+@[a-z]+\\.[a-z]{2,6}" //"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: emailTextField.text)
    }
    
    func checkFullname(fullnameTextField: UITextField) -> Bool {
        let REGEX: String
        REGEX = "[A-Za-z ]{1,}" //from Aa to Zz, accept white space, minimum letters is 1 up to unlimit
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: fullnameTextField.text)
    }

    
}// Ends of class


