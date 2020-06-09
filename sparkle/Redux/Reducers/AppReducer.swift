//
//  AppReducer.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//
import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        searchState: searchReducer(action: action, state: state?.searchState),
        tweetDetail: tweetDetailReducer(action: action, state: state?.tweetDetail),
        splashState: splashReducer(action: action, state: state?.splashState),
        counterState: counterReducer(action: action, state: state?.counterState),
        viewState: viewReducer(action: action, state: state?.viewState)
    )
}
