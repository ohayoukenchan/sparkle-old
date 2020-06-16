//
//  SearchBooksAction.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/10.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import RxSwift
import ReSwift
import SparkleClient

struct RequestBookSearchSuccess: Action {
    let response: [Book]
}
struct RequestBookSearchError: Action {}