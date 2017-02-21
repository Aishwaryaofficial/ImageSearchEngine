//
//  FullImageVC.swift
//  ImageSearchEngine
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage


class FullImageVC: UIViewController {
    
    // MARK: variable
    
    @IBOutlet weak var fullImageView: UIImageView!
    var  imageURL : URL!

    //MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullImageView.af_setImage(withURL : imageURL )

    }
    
    override func viewWillLayoutSubviews() {
      
        super.viewWillLayoutSubviews()

    }
    
}
