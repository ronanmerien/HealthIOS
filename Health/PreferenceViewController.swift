//
//  PreferenceViewController.swift
//  Health
//
//  Created by Admin on 21/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var validate: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var nameswitch: UISegmentedControl!
    
    var preference = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func validate(_ sender: Any) {
        if self.nameswitch.selectedSegmentIndex == 0 {
            preference = false
            UserDefaults.standard.set(preference, forKey: "Ordername")
        } else {
            preference = true
            UserDefaults.standard.set(preference, forKey: "Ordername")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
