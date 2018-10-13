//
//  LogInViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField    : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func dismissLogIn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {
        guard let email    = emailTextField.text    else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                // SUCCESSFUL LOGIN
                print("Successfully Logged in")
                self.dismiss(animated: false, completion: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    
    fileprivate func setupViews() {
        logInButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: logInButton.frame.height / 2, borderColor: .white, borderWidth: 2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
