//
//  HelpViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet weak var helpContainerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBAction func doneViewingHelpView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func setupViews() {
        helpContainerView.setProperties(bgColor: nil, shadowColor: .black, shadowRadius: 5, shadowOpacity: 0.8, shadowOffset: nil, cornerRadius: 20, borderColor: nil, borderWidth: nil)
        helpContainerView.clipsToBounds = true
        
        doneButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: doneButton.frame.height / 2, borderColor: .white, borderWidth: 2)
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
