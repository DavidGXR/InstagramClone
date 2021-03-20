//
//  AlertDialog.swift
//  InstagramClone
//
//  Created by David Im on 11/17/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

class AlertDialog:LoadingIndicatorAlert{
    
    private func alertController(on vc: UIViewController, title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
            self.stopActivityIndicatorOverlayView()
        }
    }
    
    func alertSheet(on vc: UIViewController, buttonOne:String, buttonTwo:String, buttonThree:String, buttonFour:String, buttonFive:String, buttonSix:String){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let buttonOne = UIAlertAction(title: buttonOne, style: .default, handler: nil)
        let buttonTwo = UIAlertAction(title: buttonTwo, style: .default, handler: nil)
        let buttonThree = UIAlertAction(title: buttonThree, style: .default, handler: nil)
        let buttonFour = UIAlertAction(title: buttonFour, style: .default, handler: nil)
        let buttonFive = UIAlertAction(title: buttonFive, style: .default, handler: nil)
        let buttonSix = UIAlertAction(title: buttonSix, style: .destructive, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(buttonSix)
        alertController.addAction(buttonFive)
        alertController.addAction(buttonFour)
        alertController.addAction(buttonThree)
        alertController.addAction(buttonTwo)
        alertController.addAction(buttonOne)
        alertController.addAction(cancel)
        
        DispatchQueue.main.async {
            alertController.view.tintColor = UIColor.black
            vc.present(alertController, animated: true, completion: nil)
        }
    }
        
    func showInvalidEmailAlert(on vc: UIViewController){
        alertController(on: vc, title: "Email is Badly Formatted", message: "Try to write an appropriate email.", buttonTitle: "Try again")
    }
    
    func showInvalidPasswordAlert(on vc: UIViewController){
        alertController(on: vc, title: "Incorrect Password", message: "The password you entered is incorrect. Please try again.", buttonTitle: "Try again")
    }
    
    func showInvalidDataAlert(on vc: UIViewController){
        self.alertController(on: vc, title: "Incorrect Password", message: "The password you entered is incorrect. Please try again.", buttonTitle: "Try again")
    }
}
