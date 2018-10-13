//
//  SignUpViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField : UITextField!
    @IBOutlet weak var lastNameTextField  : UITextField!
    @IBOutlet weak var emailTextField     : UITextField!
    @IBOutlet weak var passwordTextField  : UITextField!
    @IBOutlet weak var signUpButton       : UIButton!
    
    
    @IBAction func signUp(_ sender: UIButton) {
        
    }
    
    
    fileprivate func setupViews() {
        signUpButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: signUpButton.frame.height / 2, borderColor: .white, borderWidth: 2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
