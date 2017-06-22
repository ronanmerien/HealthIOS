//
//  PatientTableViewController.swift
//  Health
//
//  Created by Admin on 20/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import CoreData

class PatientTableViewController: UITableViewController {
    
    var patients = [PatientData]()
    var iterator: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.reloadData()
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showCreateViewController))
        let pref = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showPrefViewController))
        let john = Patient(prenom: "John", nom: "Do", genre: .Male)
        let sylvie = Patient(prenom: "Sylvie", nom: "Goulard", genre: .Female)
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.leftBarButtonItem = pref
        
        //patients.append(john)
        //patients.append(sylvie)
        
        //CoreData
        let johnData = PatientData(entity: PatientData.entity(), insertInto: persistentContainer.viewContext)
        johnData.prenom = "John"
        johnData.nom = "Malkovic"
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(error)
        }
        
        let fileUrl = Bundle.main.url(forResource: "names", withExtension: "plist")
        guard let url = fileUrl, let array = NSArray(contentsOfFile: url.path) else {
            return
        }
        
        for dict in array {
            if let dictionnary = dict as? [String:Any] {
                let firstName = dictionnary["name"] as? String ?? "Error"
                let lastName = dictionnary["lastname"] as? String ?? "Error"
                
                if let isFemale = dictionnary["isFemale"] as? Bool, isFemale == true {
                    //self.patients.append(Patient(prenom: firstName, nom: lastName, genre: .Male))
                } else {
                    //self.patients.append(Patient(prenom: firstName, nom: lastName, genre: .Male))
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        let fetchRequest = NSFetchRequest<PatientData>(entityName: "PatientData")
        let sort = NSSortDescriptor(key: "nom", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            self.patients = try persistentContainer.viewContext.fetch(fetchRequest)
            print(patients)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func showCreateViewController() {
        let controller = CreatePatientViewController(nibName: "CreatePatientViewController", bundle: nil)
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    func showPrefViewController() {
        let controller = PreferenceViewController(nibName: "PreferenceViewController", bundle: nil)
        self.present(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return patients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientCell", for: indexPath)

        // Configure the cell...
        if UserDefaults.standard.bool(forKey: "Ordername") == false {
            cell.textLabel?.text = patients[indexPath.row].afficherNomComplet()
        } else {
            cell.textLabel?.text = patients[indexPath.row].afficherReverseNomComplet()
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let detailController = segue.destination as? DetailViewController {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            detailController.patient = patients[selectedIndexPath.row]
            //CLOSURE
            //suppression de la ligne sléectionée
            detailController.onDelete = {
                let patient = self.patients[selectedIndexPath.row]
                self.persistentContainer.viewContext.delete(patient)
                try? self.persistentContainer.viewContext.save()
                //self.patients.remove(at: selectedIndexPath.row)
                self.tableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        /*if let prefController = segue.destination as? PreferenceViewController {
            prefController.onChangeSwitch = {
                if self.iterator == 0 {
                    self.iterator = 1
                } else {
                    self.iterator = 0
                }
                self.tableView.reloadData()
            }
        }*/
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//DELEGATE
//Sert à implementer les actions de la class dans notre vue
extension PatientTableViewController: CreatePatientViewControllerDelegate {
    
    func createPatient(patient: Patient) {
        //patients.append(patient)
        tableView.reloadData()
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
