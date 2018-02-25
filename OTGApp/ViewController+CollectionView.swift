//
//  ViewController+CollectionView.swift
//  OTGApp
//
//  Created by Gurinder Singh on 2/24/18.
//  Copyright © 2018 Gurinder Singh. All rights reserved.
//

import Foundation
import UIKit

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OTGNetworking.sharedInstance.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
       let item = OTGNetworking.sharedInstance.items[indexPath.row]
       guard let url = URL(string: item.thumbnailUrl) else { return  UICollectionViewCell()}
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                let imageView = UIImageView(image: UIImage(data: data))
                cell.contentView.addSubview(imageView)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = OTGNetworking.sharedInstance.items[indexPath.row]
        guard let url = URL(string: item.url) else { return }
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                let imageView = UIImageView(image: UIImage(data: data))
                let fullScreenVC = UIViewController()
                fullScreenVC.view  = imageView
                self.navigationController?.pushViewController(fullScreenVC, animated: true)
            }
        }

    }
    

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            let data = UIImagePNGRepresentation(cachedImage) as Data?
            print("using the cace")
            completion(data, nil,nil)
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
}
