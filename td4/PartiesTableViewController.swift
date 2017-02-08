//
//  PartiesTableViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 30/01/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit
import SWXMLHash


struct Categorie {
    var Id : Int
    var Sort : Int
    var Name : String
    var NbrElement: Int
}
/*
struct Element {
    var Id : Int = 0
    var CategoryId : Int = 0
    var Bundle : Int = 0
    var Sort : Int = 0
    var Image : URL = NSURLComponents().url!
    var ImageLarge : URL = NSURLComponents().url!
    var Subname : String = "";
    var Phone : String = "";
    var Email : String = "";
    var Descr : String = "";
}*/

struct Element {
    /*var Id : Int = 0
    var CategoryId : Int = 0
    var Bundle : Int = 0
    var Sort : Int = 0*/
    
    /*
    var Image : URL = NSURLComponents().url!
    var ImageLarge : URL = NSURLComponents().url!
    */
    
    var Image : String = "";
    var ImageLarge : String = "";
    var Name : String = "";

    
    /*var Phone : String = "";
    var Email : String = "";
    var Descr : String = "";*/
}


struct Event {
    var Subtype : Int = 0
    var Id : Int = 0
    var Name : String = "";
    var DateStart : Date = Date()
    var TimeStart : Date = Date()
    var DateEnd : Date = Date()
    var TimeEnd : Date = Date()
    var Phone : String = "";
    var Email : String = "";
    var Descr : String = "";
    var YoutubeId : Int = 0
    var Image : URL = NSURLComponents().url!
}

class CategorieCell : UITableViewCell {

    @IBOutlet weak var image_large: UIImageView!
    @IBOutlet weak var element: UILabel!
}

class elementVue : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brown;
        
        
        
        
        /*
        let label = UILabel(frame: CGRect(x: 10, y: 65, width: UIScreen.main.bounds.width, height: 21))
        label.text = "I'am a test label\ndfdsfdsfds"*/
        
        var descHtml = UIWebView();

        self.view.addSubview(descHtml)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}

class PartiesTableViewController: UITableViewController {

    var categoriesList  = [Categorie]()
    var elementList = [Element]();

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=en") {
            
            if let data = try? Data(contentsOf: url) {
                
                let xml = SWXMLHash.parse(data)

                
                //On parcourt les categories
                for categories in xml["data"]["categories"]["category"].all {
                    
                    var nbrElement = 0;
                    
                    //On parcourt les éléments
                    for elements in categories["element"].all {
                        
                        //On créé l'élément
                        let element = Element(
                            Image: (elements.element?.allAttributes["image"]?.text)!,
                            ImageLarge: (elements.element?.allAttributes["image_large"]?.text)!,
                            Name: (elements.element?.allAttributes["name"]?.text)!
                        );
                        
                        nbrElement += 1;
                        
                        //On rajoute l'élément
                        self.elementList.append(element)
                    }

                    //On crée la catégorie
                    let categorie = Categorie(
                        Id: Int((categories.element?.allAttributes["id"]?.text)!)!,
                        Sort: Int((categories.element?.allAttributes["sort"]?.text)!)!,
                        Name: (categories.element?.allAttributes["name"]?.text)!,
                        NbrElement: nbrElement
                    )
                    
                    //On ajoute la catégorie
                    self.categoriesList.append(categorie)
                }
           }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesList[section].NbrElement;
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorie", for: indexPath) as! CategorieCell
        
        let imgView = cell.image_large;
        
        //On change l'image par défaut
        imgView?.image = UIImage(named: "picture")

        //On récupère les informations
        let name = elementList[indexPath.row].Name;
        let image = elementList[indexPath.row].Image;
        
        cell.element.text = elementList[indexPath.row].Name;

        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if let data = try? Data(contentsOf: NSURL(string: image) as! URL) {
                DispatchQueue.main.async(execute: {
                    
                    imgView?.alpha = 0
                    
                    UIView.transition(with: imgView!, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                        imgView?.image = UIImage(data: data)
                        imgView?.alpha = 1
                    }, completion: { (ended) -> Void in
                        
                    })
                })
            }
        }
        return cell
    }

    
    //Contenu de la section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoriesList[section].Name;
    }
    
    //Renvoie le nombre de section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesList.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let maVue = elementVue();

        self.navigationController?.pushViewController(maVue, animated: true)
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
