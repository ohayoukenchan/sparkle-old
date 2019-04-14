//
//  String+Random.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/18.
//  Copyright © 2018 Takano Kenta. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
