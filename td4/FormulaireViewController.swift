//
//  FormulaireViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 09/02/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit
import MessageUI

//Fonction permettant de faire les regex
func validRegex(str: String, pattern: String) -> Bool {
    let emailTest = NSPredicate(format:"SELF MATCHES %@", pattern)
    return emailTest.evaluate(with: str)
}

class FormulaireViewController: UIViewController {

    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var rappelerSwitch: UISwitch!
    
    @IBAction func sendFormulaire(_ sender: UIButton) {
        
        //On regarde si toutes les valeurs demandées sont présentes
        if(
            nomTextField.text != "" &&
            prenomTextField.text != "" &&
            emailTextField.text != "" &&
            telephoneTextField.text != ""
        ) {
            
            //On précise les regex des éléments
            let regexEmail = validRegex(str: emailTextField.text!, pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}");
            let regexNom = validRegex(str: nomTextField.text!, pattern: "[A-Za-z]{5,}+");
            let regexPrenom = validRegex(str: prenomTextField.text!, pattern: "[A-Za-z]{5,}+");
            let regexTelephone = validRegex(str: telephoneTextField.text!, pattern: "[0-9]{10}");
        
            var verifRegex = false;
            var errorRegex : String = "";
            
            if(regexEmail) {

                if(regexTelephone) {
                
                    if(regexNom) {
                    
                        if(regexPrenom) {
                            
                            var ifRappel = "";
                            
                            if(rappelerSwitch.isOn) {
                                ifRappel = "OUI";
                            } else {
                                ifRappel = "NON";
                            }
                            
                            //On génère le contenu du mail
                            var contentHtml = "<p><strong><u>Nom :</u></strong> " + nomTextField.text! + "</p>";
                            contentHtml = contentHtml + "<p><strong><u>Prénom :</u></strong> " + prenomTextField.text! + "</p>";
                            contentHtml = contentHtml + "<p><strong><u>Email : </u></strong> " + emailTextField.text! + "</p>";
                            contentHtml = contentHtml + "<p><strong><u>Téléphone : </u></strong> " + telephoneTextField.text! + "</p>";
                            contentHtml = contentHtml + "<p><strong><u>Être rappelé: </u></strong> " + ifRappel + "</p>";
                            
                            //On envoie le mail (A TESTER)
                            if MFMailComposeViewController.canSendMail() {
                                let mail = MFMailComposeViewController()
                                mail.setToRecipients([emailTextField.text!])
                                mail.setMessageBody(contentHtml, isHTML: true)
                                
                                present(mail, animated: true)
                            }
                            
                            //On précise que toutes les regex ont été vérifiées
                            verifRegex = true;
                            
                            let alert = UIAlertController(title: "Félicitations", message: "Le mail a bien été envoyé !", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Merci maître !", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        
                        } else {
                            errorRegex = "Le prénom doit composer au moins 5 caractères.";
                        }
                    } else {
                        errorRegex = "Le nom doit composer au moins 5 caractères.";
                    }
                    
                } else {
                    errorRegex = "Le numéro de téléphone n'est pas du bon format.";
                }
                
            } else {
                errorRegex = "L'adresse e-mail n'est pas du bon format."
            }
            
            //Si une regex n'a pas été validée
            if(!verifRegex) {
                let alert = UIAlertController(title: "Erreur", message: errorRegex, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Oui maître, je corrige ça !", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "Formulaire", message: "Les éléments ne sont pas tous remplis.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "J'ai compris !", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
