//
//  CDListingModel.swift
//  CodersBrain
//
//  Created by Happlabs Software LLP MAC1 on 27/03/18.
//  Copyright © 2018 Farooque. All rights reserved.
//

import Foundation

class CBListingModel: NSObject {
    
    var images : String?
    var name : String?
    var storiesArray : NSArray?
    
    init(json: NSDictionary) {
        self.images = json["imageURL"] as? String
        self.name = json["name"] as? String
        self.storiesArray = json["storiesInside"] as? NSArray
    }
}
