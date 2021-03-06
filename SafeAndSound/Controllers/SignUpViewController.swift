//
//  SignUpViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {
    @IBOutlet weak var fullnameTextField  : UITextField!
    @IBOutlet weak var emailTextField     : UITextField!
    @IBOutlet weak var passwordTextField  : UITextField!
    @IBOutlet weak var signUpButton       : UIButton!
    
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        guard let fullname  = fullnameTextField.text  else { return }
        guard let email     = emailTextField.text     else { return }
        guard let password  = passwordTextField.text  else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                // SUCCESSFUL LOGIN
                print("User Created")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fullname
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        print("User display name changed")
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            }
            else {
                print("Error: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    
    fileprivate func setupViews() {
        signUpButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: signUpButton.frame.height / 2, borderColor: .white, borderWidth: 2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
