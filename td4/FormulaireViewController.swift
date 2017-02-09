//
//  FormulaireViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 09/02/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
