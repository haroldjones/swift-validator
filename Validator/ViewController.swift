//
//  ViewController.swift
//  Validator
//
//  Created by Jeff Potter on 11/20/14.
//  Copyright (c) 2014 jpotts18. All rights reserved.
//

import UIKit

class ViewController: UIViewController , ValidationDelegate, UITextFieldDelegate {

    // TextFields
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    // Error Labels
    @IBOutlet weak var fullNameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var zipcodeErrorLabel: UILabel!
    
    let KEYS = ["Full Name", "Email", "Phone", "ZipCode"]
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        zipcodeTextField.delegate = self
        
        validator.registerFieldByKey(KEYS[0], textField: fullNameTextField, rules: [.Required, .FullName])
        validator.registerFieldByKey(KEYS[1], textField: emailTextField, rules: [.Required, .Email])
        validator.registerFieldByKey(KEYS[2], textField: phoneNumberTextField, rules: [.Required, .PhoneNumber])
        validator.registerFieldByKey(KEYS[3], textField: zipcodeTextField, rules: [.Required, .ZipCode])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func submitTapped(sender: AnyObject) {
        println("Validating...")
        validator.validateAllKeys(self)
    }
    
    // MARK: Error Styling
    
    func setError(label:UILabel, error:ValidationError) {
        label.hidden = false
        label.text = error.error.description()
        error.textField.layer.borderColor = UIColor.redColor().CGColor
        error.textField.layer.borderWidth = 2.0
    }

    func removeError(label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(fullNameErrorLabel, textField: fullNameTextField)
        removeError(emailErrorLabel, textField: emailTextField)
        removeError(phoneNumberErrorLabel, textField: phoneNumberTextField)
        removeError(zipcodeErrorLabel, textField: zipcodeTextField)
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationFailed(errors: [String : ValidationError]) {
        
        println("Found \(errors.count) errors")
        
        if var fullNameError = errors[KEYS[0]] {
            setError(fullNameErrorLabel, error: fullNameError)
        } else {
            removeError(fullNameErrorLabel, textField: fullNameTextField)
        }
        
        if var emailNameError = errors[KEYS[1]] {
            setError(emailErrorLabel, error: emailNameError)
        } else {
            removeError(emailErrorLabel, textField: emailTextField)
        }
        
        if var phoneError = errors[KEYS[2]] {
            setError(phoneNumberErrorLabel, error: phoneError)
        } else {
            removeError(phoneNumberErrorLabel, textField: phoneNumberTextField)
        }
        
        if var zipError = errors[KEYS[3]] {
            setError(zipcodeErrorLabel, error: zipError)
        } else {
            removeError(zipcodeErrorLabel, textField: zipcodeTextField)
        }
    }
    
    func validationWasSuccessful() {
        
        println("Everything checks out!")
        
        removeAllErrors()
        
        var alert = UIAlertController(title: "Valid!", message: "Everything looks good to me", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}

