//
//  ShrineData.swift
//  ShrineClone
//
//  Created by Aidan Aden on 14/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShrineData: NSObject {
    
    var imageNames = NSMutableArray()
    var titles = NSMutableArray()
    var descriptions = NSMutableArray()
    var prices = NSMutableArray()
    var avatars = NSMutableArray()
    var shopTitles = NSMutableArray()
    static var baseURL = "https://www.gstatic.com/angular/material-adaptive/shrine/"
    
    func readJSON() {
        
        let filePath = Bundle.main.path(forResource: "products", ofType: "json")
        var json: JSON!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath!))
//            let options = JSONSerialization.ReadingOptions()
//            json = try JSONSerialization.jsonObject(with: data!, options: options) as? NSDictionary
            json = JSON(data: data)
        } catch _ {
            print("Couldn't get JSON data")
        }
        
        let products = json["products"].arrayValue
        for prod in products {
            let product = prod 
            let imageName = product["image"].stringValue
            imageNames.add(imageName)
            let title = product["title"].stringValue
            titles.add(title)
            let description = product["description"].stringValue
            descriptions.add(description)
            let price = product["price"].stringValue
            prices.add(price)
        }
        
        let shops = json["shops"].arrayValue
        for shp in shops {
            let shop = shp
            let avatar = shop["avatar"].stringValue
            avatars.add(avatar)
            let shopTitle = shop["shop"].stringValue
            shopTitles.add(shopTitle)
        }
    }
}



