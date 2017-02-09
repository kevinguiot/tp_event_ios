//
//  ElementVueViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 09/02/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit

class ElementVueViewController: UIViewController {

    var descr : String = "";
    var name : String = "";
    var imageLarge : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        
        //Si l'image l'arge est mentionnée
        if(imageLarge != "") {
            
            var imgView = UIImageView(frame: UIScreen.main.bounds);
            
            //On mets l'image par défaut
            imgView.image = UIImage(named: "picture");
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                if let data = try? Data(contentsOf: NSURL(string: self.imageLarge) as! URL) {
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
            
            self.view.addSubview(imgView)
            
        } else {
            var descHtml = UIWebView(frame: UIScreen.main.bounds);
            
            descHtml.isOpaque = false;
            descHtml.backgroundColor = UIColor.darkGray;
            descHtml.loadHTMLString(descr, baseURL: nil);
            
            self.view.addSubview(descHtml)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
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
