//
//  OnboardingViewController.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/14/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBAction func onGetStarted(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
