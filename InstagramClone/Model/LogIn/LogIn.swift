//
//  LogIn.swift
//  InstagramClone
//
//  Created by David Im on 7/25/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import Firebase

class LogIn: NSObject{
    
    @objc dynamic var error: String?
    
    func logIn(email: String, password: String) {
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.error = err.localizedDescription
                }else{
                    self.error = C.success
                }
            }
        }
    }
    
    func checkIfLogIn() {
        if Auth.auth().currentUser != nil {
            self.error = C.success
        } else {
            return
        }
    }
}
