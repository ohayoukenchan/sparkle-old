//
//  String+PercentEncoding.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/18.
//  Copyright © 2018 Takano Kenta. All rights reserved.
//

import Foundation

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String {
        let unreserved = "-._~"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        
        if let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) {
            return encodedString
        }
        
        return self
    }
}
