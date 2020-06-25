//
//  UserDefaults+Ex.swift
//  Redux
//
//  Created by  ohayoukenchan on 2020/06/25.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//
import Foundation

public extension UserDefaults {

    func set<T: Codable>(object: T, forKey: String) throws {
        let jsonData = try JSONEncoder().encode(object)
        set(jsonData, forKey: forKey)
    }

    func get<T: Codable>(forKey: String) throws -> T? {
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: result)
    }
}
