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
    
    var  imageURL : URL!

    //MARK: LIFE CYCLE
@IBOutlet weak var fullImageView: UIImageView!
    override func viewDidLoad() {
    super.viewDidLoad()
        }
    override func viewWillLayoutSubviews() {
      
    fullImageView.af_setImage(withURL : imageURL )

    }
}
