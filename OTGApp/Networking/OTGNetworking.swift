//
//  OTGNetworking.swift
//  OTGApp
//
//  Created by Gurinder Singh on 2/24/18.
//  Copyright © 2018 Gurinder Singh. All rights reserved.
//

import Foundation

class OTGNetworking {
    
    static let sharedInstance = OTGNetworking()
    let endpointURL = "https://jsonplaceholder.typicode.com/photos"
    
    var items = [Item]()
    
    
    func getItemsFromEndpoint(completionHandler:@escaping (Bool) -> ()){
        guard let url = URL(string: endpointURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let loadedItems = try decoder.decode([Item].self, from: data)
                self.items = loadedItems
                
                completionHandler(true)
            } catch let err {
                print("Err", err)
                completionHandler(false)
            }
        }.resume()
    }
    
}
