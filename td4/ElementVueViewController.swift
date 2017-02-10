//
//  ElementVueViewController.swift
//  td4
//
//  Created by GUIOT Kevin on 09/02/2017.
//  Copyright © 2017 GUIOT Kevin / RUGOLETTO Romuald. All rights reserved.
//

import UIKit
import SDWebImage

class ElementVueViewController: UIViewController {

    var descr : String = "";
    var name : String = "";
    var imageLarge : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        
        //Si l'image l'arge est mentionnée
        if(imageLarge != "") {
            let imgView = UIImageView(frame: UIScreen.main.bounds);

            imgView.sd_setImage(with: URL(string: imageLarge), placeholderImage: UIImage(named: "picture"))

            self.view.addSubview(imgView)
            
        } else {
            let descHtml = UIWebView(frame: UIScreen.main.bounds);
            
            descHtml.isOpaque = false;
            descHtml.backgroundColor = UIColor.darkGray;
            descHtml.loadHTMLString(descr, baseURL: nil);
            
            self.view.addSubview(descHtml)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}
