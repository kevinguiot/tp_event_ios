//
//  FormulaireViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 09/02/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit
import MessageUI

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
                mail.setToRecipients(["contact@kevinguiot.fr"])
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                
                present(mail, animated: true)
            }
            
        } else {
            let alert = UIAlertController(title: "Formulaire", message: "Les éléments ne sont pas tous remplis.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "J'ai compris", style: UIAlertActionStyle.default, handler: nil))
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
