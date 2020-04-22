//
//  SplashReducer.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/04/22.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift

func splashReducer(action: Action, state: SplashState?) -> SplashState {
    var state = state ?? SplashState(test: false)

    switch action {
    case _ as SplashState:
        state.test = false
    default:
        break
    }

    return state
}
