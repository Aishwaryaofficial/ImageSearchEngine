//
//  MainVC.swift
//  ImageSearchEngine
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class MainVC : UIViewController {
    
    //MARK:   @IBOutlet
    
   
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
   
    // MARK: DECLEARING XIB
    
    let imageCell = Xib(name: "ImageCell", id: "ImageCellID")
    let fullImageVC = Xib(name: "FullImageVC", id: "FullImageID")

    var imagesList : [ImageInfo] = []

    //  MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let cellNib = UINib(nibName:imageCell.name , bundle: nil)
        imageCollectionView.register(cellNib, forCellWithReuseIdentifier: imageCell.id)
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        searchBar.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 120)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        imageCollectionView.collectionViewLayout = flowLayout
        
    }
    
    func fetchDataFromPixabay(withQuery query: String) {
       
        Webservices().fetchDataFromPixabay(withQuery: query,
                                           success: { (images : [ImageInfo]) in
                                            
            if images.count == 0 {
                let alert = UIAlertController(title: "Alert", message: "Not Found", preferredStyle: .alert )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                                                
            }
            
            self.imagesList = images
            self.imageCollectionView.reloadData()
            
            }) { (error : Error) in
        
                let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: .alert )
              alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
}
// MARK: UISearchBarDelegate
extension MainVC : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
   
        fetchDataFromPixabay( withQuery: searchBar.text!)
        
    }
}

// MARK: UICollectionViewDataSource,UICollectionViewDelegate

extension MainVC : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: imageCell.id, for:
            indexPath) as! ImageCell
        
        if let url = URL(string: imagesList[indexPath.row].previewURL) {
            cell.imageView.af_setImage(withURL : url)
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageShow = navigationController?.storyboard?.instantiateViewController(withIdentifier: fullImageVC.id) as! FullImageVC
        imageShow.imageURL = URL(string: imagesList[indexPath.row].webformatURL)
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.pushViewController(imageShow, animated: true)
            UIView.setAnimationTransition(.curlUp, for: self.navigationController!.view!, cache: false)
        })
    }
    
}

