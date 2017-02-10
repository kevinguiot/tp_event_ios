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
    var Name : String
    var Elements = [Element]()
}

struct Element {
    var Image : String = "";
    var ImageLarge : String = "";
    var Name : String = "";
    var Descr : String = "";
}

class CategorieCell : UITableViewCell {

    @IBOutlet weak var image_large: UIImageView!
    @IBOutlet weak var element: UILabel!
}

class PartiesTableViewController: UITableViewController {

    var categoriesList  = [Categorie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Catégories";

        //BONUS: on change la langue du xml dynama
        let lang = Locale.current.languageCode

        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=" + lang!) {
            
            if let data = try? Data(contentsOf: url) {
                
                let xml = SWXMLHash.parse(data)

                //On parcourt les categories
                for categories in xml["data"]["categories"]["category"].all {

                    var elementList = [Element]();

                    //On parcourt les éléments
                    for elements in categories["element"].all {
                        
                        //On créé l'élément
                        let element = Element(
                            Image: (elements.element?.allAttributes["image"]?.text)!,
                            ImageLarge: (elements.element?.allAttributes["image_large"]?.text)!,
                            Name: (elements.element?.allAttributes["name"]?.text)!,
                            Descr: (elements.element?.allAttributes["descr"]?.text)!
                        );
                        
                        //On rajoute l'élément
                        elementList.append(element)
                    }

                    //On créé la catégorie
                    let categorie = Categorie(
                        Id: Int((categories.element?.allAttributes["id"]?.text)!)!,
                        Name: (categories.element?.allAttributes["name"]?.text)!,
                        Elements: elementList
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
        return categoriesList[section].Elements.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorie", for: indexPath) as! CategorieCell
        
        let imgView = cell.image_large;
        
        //On change l'image par défaut
        imgView?.image = UIImage(named: "picture")
        
        //On récupère les informations
        let name = categoriesList[indexPath.section].Elements[indexPath.row].Name;
        let image = categoriesList[indexPath.section].Elements[indexPath.row].Image;
        
        cell.element.text = name;
        
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
        var sectionName = categoriesList[section].Name;
        
        //Si on ignore les sections vide
        if(categoriesList[section].Elements.count == 0) { sectionName = ""; }
        
        return sectionName;
    }
    
    //Renvoie le nombre de section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesList.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = categoriesList[indexPath.section].Elements[indexPath.row];
        let elementVue = ElementVueViewController();

        elementVue.descr      = element.Descr;
        elementVue.name       = element.Name;
        elementVue.imageLarge = element.ImageLarge;

        self.navigationController?.pushViewController(elementVue, animated: true)
    }
}
