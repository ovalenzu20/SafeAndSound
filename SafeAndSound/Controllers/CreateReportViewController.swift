//
//  CreateReportViewController.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class CreateReportViewController: UIViewController {
    @IBOutlet weak var cancelButton  : UIButton!
    @IBOutlet weak var submitButton  : UIButton!
    @IBOutlet weak var containerView : UIView!
    
    
    @IBAction func cancelSubmission(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitReport(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Thank you for your submission!", message: "Other Safe&Sound users have been notified of your report.", preferredStyle: .alert)
        let okAction    = UIAlertAction(title: "Done", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: cancelButton.frame.height/2, borderColor: .white, borderWidth: 2)
        
        submitButton.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: cancelButton.frame.height/2, borderColor: .white, borderWidth: 2)
        
        containerView.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: 20, borderColor: nil, borderWidth: nil)
        
        containerView.clipsToBounds = true
    }
}
