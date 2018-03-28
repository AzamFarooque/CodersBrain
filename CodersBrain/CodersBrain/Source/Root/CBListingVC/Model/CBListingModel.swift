//
//  CDListingModel.swift
//  CodersBrain
//
//  Created by Farooque on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import Foundation

class CBListingModel: NSObject {
    
    var images : String?
    var news : String?
    var newsDetail : String?
    
    init(json: NSDictionary) {
        self.images = json["imageURL"] as? String
        self.news = json["news"] as? String
        self.newsDetail = json["newsDetail"] as? String
    }
}
