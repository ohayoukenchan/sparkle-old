//
//  AuthState.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/10.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import TwitterKit
import ReSwift

struct AuthState: StateType {
    var session: TWTRAuthSession?
    var error: NSError?
    var loggedInState: LoggedInState = .idle
}

enum LoggedInState {
    case idle
    case notLoggedIn
    case loggedIn
}
