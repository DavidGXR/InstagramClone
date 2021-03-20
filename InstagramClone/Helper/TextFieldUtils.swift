//
//  Alert.swift
//  InstagramClone
//
//  Created by David Im on 10/19/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

class TextFieldUtils:LoadingIndicatorAlert{
    
    func textFieldAlert(textField:UITextField, icon:String){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 40, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: icon)
        rightView.addSubview(imageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
    }
    
    func errorTextField(txtField: UITextField, errorLabel: UILabel, errorText: String, disableButton: UIButton){
        DispatchQueue.main.async {
            self.textFieldAlert(textField: txtField, icon: C.crossIcon)
            txtField.layer.borderColor = UIColor.red.cgColor
            txtField.layer.borderWidth = 1.0
            errorLabel.isHidden = false
            errorLabel.text = errorText
            disableButton.isUserInteractionEnabled = false
            disableButton.alpha = 0.5
            self.stopActivityIndicatorOverlayView()
        }
    }

    func correctTextField(txtFieldCorrect: UITextField, hideLabel: UILabel, enableButton: UIButton){
        DispatchQueue.main.async {
            self.textFieldAlert(textField:txtFieldCorrect, icon: C.tickIcon)
            txtFieldCorrect.layer.borderColor = UIColor.clear.cgColor
            txtFieldCorrect.layer.borderWidth = 1.0
            hideLabel.isHidden = true
        }
    }

    func emptyTextField(txtFieldClear: UITextField, clearLabel:UILabel, disableButton: UIButton){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 40, y: 0, width: 40, height: 40))
        DispatchQueue.main.async {
            rightView.addSubview(imageView)
            txtFieldClear.rightView = rightView
            txtFieldClear.rightViewMode = .never
            txtFieldClear.layer.borderColor = UIColor.clear.cgColor
            txtFieldClear.layer.borderWidth = 1.0
            clearLabel.isHidden = true
            disableButton.isUserInteractionEnabled = false
            disableButton.alpha = 0.5
        }
    }

    func hideErrorLabel(emailErrorLabel: UILabel, passwordErrorLabel: UILabel, fullnameErrorLabel: UILabel, usernameErrorLabel: UILabel){
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        fullnameErrorLabel.isHidden = true
        usernameErrorLabel.isHidden = true
    }
    
    func startActivityIndicatorOnTextField(for textField:UITextField){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        DispatchQueue.main.async {
            self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 40, y: 0, width: 40.0, height: 40.0))
            rightView.addSubview(self.activityIndicator)
            textField.rightView = rightView
            textField.rightViewMode = .always
            self.startActivityIndicator(color: .black)
        }
    }
    
    func boldText(boldText:Int, regularText:String, size:CGFloat) -> NSAttributedString {
        let typeOfFont      = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)]
        let convertToBold   = NSMutableAttributedString(string: String(boldText)+"\n", attributes: typeOfFont)
        convertToBold.append(NSAttributedString(string: regularText,attributes: nil))

        return convertToBold
    }

}

