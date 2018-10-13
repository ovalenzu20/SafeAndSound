//
//  SignInViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    fileprivate func setupViews() {
        logInButton.layer.cornerRadius = 4
        logInButton.layer.borderColor  = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        logInButton.layer.borderWidth  = 2
        
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.borderColor  = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        signUpButton.layer.borderWidth  = 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
