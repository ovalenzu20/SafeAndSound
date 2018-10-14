//
//  ProfileViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    @IBOutlet weak var signOutButton    : UIButton!
    @IBOutlet weak var profileImageView : UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBAction func signOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    @IBAction func dismissProfileView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupViews() {
        userNameLabel.text = Auth.auth().currentUser?.displayName
        emailLabel.text    = Auth.auth().currentUser?.email
        
        signOutButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: signOutButton.frame.height / 2, borderColor: .white, borderWidth: 2)
        profileImageView.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: profileImageView.frame.height / 2, borderColor: .white, borderWidth: 4)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
