//
//  MenuViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit
import Firebase


class MenuViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    fileprivate func setupViews() {
        logInButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: logInButton.frame.height / 2, borderColor: .white, borderWidth: 2)
        
        
        signUpButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: signUpButton.frame.height / 2, borderColor: .white, borderWidth: 2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toMainScreen", sender: self)
        }
    }
}
