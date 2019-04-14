//
//  AuthReducer.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift

func authReducer(action: Action, state: AuthState?) -> AuthState {
    var state = state ?? AuthState()
    
    switch action {
    case let action as LoadAuthAction:
        state.session = action.session
        state.error = nil
        state.loggedInState = .loggedIn
    case let action as ErrorAuthAction:
        state.session = nil
        state.error = action.error
        state.loggedInState = .notLoggedIn
    default:
        break
    }
    
    return state
}
