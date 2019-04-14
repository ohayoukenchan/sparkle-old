//
//  Tweet.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/18.
//  Copyright © 2018 Takano Kenta. All rights reserved.
//

import Foundation
import ObjectMapper

class Tweet: Mappable, Codable {
    var id: String!
    var username: String!
    var thumbnailUrl: String!
    var createdAt: Date!
    var text: String!
    var tweetImageUrl: String?
    
    var readableCreatedAt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.init(identifier: "tr_TR")
        
        return dateFormatter.string(from: createdAt)
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id_str"]
        username <- map["user.screen_name"]
        text <- map["text"]
        thumbnailUrl <- map["user.profile_image_url_https"]
        createdAt <- (map["created_at"], CustomDateFormatTransform(formatString: "EEE MMM dd HH:mm:ss Z yyyy"))
        tweetImageUrl <- map["entities.media.0.media_url_https"]
    }
}
