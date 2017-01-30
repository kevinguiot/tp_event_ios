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
}

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

class categorieCell: UITableViewCell {
    
    
    @IBOutlet weak var element: UILabel!
    @IBOutlet weak var flyer: UIImageView!
    
    @IBAction func button(_ sender: UIButton) {
        
        
        
    }
    
}

class PartiesTableViewController: UITableViewController {

    var categories  = [Categorie]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://sealounge.lanoosphere.com/seadata_en.xml") {
            if let data = try? Data(contentsOf: url) {
                let xml = SWXMLHash.parse(data)

                //On parcourt les categories
                for categorie in xml["Data"]["categories"] {
                    
                    //On crée la catégorie
                    let categorie = Categorie(
                        Id: Int((categorie.element?.allAttributes["id"]?.text)!)!,
                        Sort: Int((categorie.element?.allAttributes["sort"]?.text)!)!,
                        Name: (categorie.element?.allAttributes["name"]?.text)!
                    )
                    
                    //On ajoute la catégorie
                    self.categories.append(categorie)
                }
           }
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.categories.count;
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //On récupère la cellule
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! categorieCell
        
        //On récupère l'événement
        let event = categories[indexPath.row];
        
        cell.element?.text = "element";

        /*
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categories", for: indexPath)
        
        /*
   
        
        
        
        let element = cell.contentView.viewWithTag(26) as! UILabel
        nameLbl.text = events[indexPath.row].name
        
        let dateLbl = cell.contentView.viewWithTag(27) as! UILabel
        dateLbl.text = "Le \(dateFormatter.string(from: events[indexPath.row].date))"
        
        let timeLbl = cell.contentView.viewWithTag(28) as! UILabel
        timeLbl.text = "\(timeFormatter.string(from: events[indexPath.row].date))H"
        
        let imgView = cell.contentView.viewWithTag(25) as! UIImageView
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if let data = try? Data(contentsOf: self.events[indexPath.row].flyer) {
                DispatchQueue.main.async(execute: {
                    imgView.alpha = 0
                    UIView.transition(with: imgView, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                        imgView.image = UIImage(data: data)
                        imgView.alpha = 1
                    }, completion: { (ended) -> Void in
                        
                    })
                })
            }
        }
        
        return cell*/*/
        
        return cell
    }
    
    


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
