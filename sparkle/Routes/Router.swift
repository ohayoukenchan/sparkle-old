//
//  Router.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/03.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift
import ReSwiftRouter

var router: Router<AppState>!

struct RouteNames {
    static let splash = "Splash"
    static let search = "Search"
    static let tweetDetail = "TweetDetail"
}
