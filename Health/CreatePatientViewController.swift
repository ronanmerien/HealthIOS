//
//  CreatePatientViewController.swift
//  Health
//
//  Created by Admin on 20/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

//DELEGATE
//Sert à définir les responsabilités de la fonction createPatient
protocol CreatePatientViewControllerDelegate: AnyObject {
    func createPatient(patient: Patient)
}

class CreatePatientViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var buttonadd: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var photo: UIButton!
    @IBOutlet weak var progressbar: UIProgressView!
    
    var patient: Patient!
    var progression: Float = 0.0
    var imagePicker: UIImagePickerController!
    
    //DELEGATE
    //Définition de la propriété du délégate
    weak var delegate:CreatePatientViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //DELEGATE
    //Action button qui vas utiliser le délégate
    @IBAction func addPatient(_ sender: Any) {
        completion()
    }
    
    func completion () -> () {
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in 0...20 {
                Thread.sleep(forTimeInterval: 0.05)
                DispatchQueue.main.async {
                    self.progressbar.setProgress(self.progression, animated: true)
                    self.progression += 0.05
                }
            }
            self.newPatient()
        }
    }
    
    func newPatient() {
        if name.text == "" {
            name.backgroundColor = .red
            surname.backgroundColor = .white
            if surname.text == "" {
                surname.backgroundColor = .red
                name.backgroundColor = .red
            }
        }
        if surname.text == "" {
            surname.backgroundColor = .red
            name.backgroundColor = .white
        } else {
            patient = Patient(prenom: String(surname.text!), nom: String(name.text!), genre: Patient.Gender.Male)
            UserDefaults.standard.set(true, forKey: "didImportData")
            let fileUrl = Bundle.main.url(forResource: "names", withExtension: "plist")
            guard let url = fileUrl, let array = NSArray(contentsOfFile: url.path) else {
                return
            }
            for dict in array {
                if let dictionnary = dict as? [String:Any] {
                    let firstName = dictionnary["name"] as? String ?? "Error"
                    let lastNa
                    me = dictionnary["lastname"] as? String ?? "Error"
                    let data = PatientData(entity: PatientData.entity(), insertInto: persistentContainer.viewContext)
                    data.prenom = surname.text!
                    data.nom = name.text!
                }
            }
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
            print(patient.afficherNomComplet())
            //DELEGATE
            //On envoie ce qu'on à crée dans cette méthode au delegate
            delegate?.createPatient(patient: patient)
        }
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
