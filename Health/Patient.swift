//
//  Patient.swift
//  Health
//
//  Created by Admin on 20/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

extension PatientData {
    func afficherNomComplet() -> String {
        if genre {
            return "\(nom!) \(prenom!)"
        } else {
            return "\(nom!) \(prenom!)"
        }
    }
    func afficherReverseNomComplet() -> String {
        return prenom! + " " + nom!
    }
}

import Foundation

class Patient {
    let prenom: String
    var nom: String
    // var nomcomplet: String
    // let nomcomplet = "\(nom)" + "\(prenom)"
    var pere: Patient?
    var mere: Patient?
    var enfants : [Patient]
    
    let genre: Gender
    
    init(prenom: String, nom: String,genre:Gender) {
        self.nom = nom
        self.prenom = prenom
        self.enfants = [Patient]()
        self.genre = genre
    }
    
    func afficherNom(){
        print(nom)
    }
    
    func afficherNomComplet() -> String {
        if  genre == Gender.Female {
            return "\(nom) \(prenom)"
        }else{
            return "\(nom) \(prenom)"
        }
    }
    
    func afficherReverseNomComplet() -> String {
        if  genre == Gender.Female {
            return "\(prenom) \(nom)"
        }else{
            return "\(prenom) \(nom)"
        }
    }
    
    func afficherenfant(){
        for enfant in enfants{
            enfant.afficherNom()
            print(enfant.afficherNomComplet())
        }
    }
    
    func afficherNomParent(){
        guard let pere = pere,let mere = mere else {
            return
        }
        pere.afficherNom()
        mere.afficherNom()
    }
    
    
    
    enum Gender {
        case Male
        case Female
    }
    
}
