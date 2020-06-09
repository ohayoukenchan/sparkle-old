//
//  AppState.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/11/01.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType {
    var authState: AuthState = AuthState()
    var navigationState: NavigationState
    var searchState: SearchState = SearchState()
    var tweetDetail: TweetDetailState = TweetDetailState()
    var splashState: SplashState = SplashState()
    var counterState: CounterState = CounterState()
    var viewState: ViewState = ViewState()
}
