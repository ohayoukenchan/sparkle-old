//
//  SearchState.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift

struct SearchState: StateType, Encodable {
    var query: String?
    var results: Result<[Tweet], TwitterAPIError>?
    var maxId: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(results, forKey: .results)
        try container.encode(maxId, forKey: .maxId)
    }
    
    private enum CodingKeys: String, CodingKey {
        case query
        case results
        case maxId
    }
}
