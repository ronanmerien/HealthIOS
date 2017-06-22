//
//  DetailViewController.swift
//  Health
//
//  Created by Admin on 20/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var patient: PatientData!
    //CLOSURE
    //type qui ne prend pas de paramètre et qui n'en renvoit pas
    var onDelete: (() -> ())?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var delete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = patient.afficherNomComplet()
        name.text = patient.nom
        surname.text = patient.prenom
        sex.text = "Femelle"
        /*if patient.genre == .Male {
            sex.text = "Mâle"
        } else {
            sex.text = "Femelle"
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttondelete(_ sender: Any) {
        onDelete!()
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
