//
//  ViewController.swift
//  OTGApp
//
//  Created by Gurinder Singh on 2/24/18.
//  Copyright © 2018 Gurinder Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var imageCache = NSCache<NSString, UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTGNetworking.sharedInstance.getItemsFromEndpoint { (success) in
            if success {
                print(OTGNetworking.sharedInstance.items.count)
                
                DispatchQueue.main.async {
                    self.itemsCollectionView.reloadData()
                }
                
            }else{
                print("error fetching resources")
            }
        }
    }

}

