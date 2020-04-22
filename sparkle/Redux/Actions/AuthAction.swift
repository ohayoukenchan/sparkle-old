//
//  AuthAction.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift
import TwitterKit
import ReSwiftRouter

extension AuthState {
    public static func authenticateUser() -> Store<AppState>.ActionCreator {
        return { state, store in
            
//            if let lastSession = LoginProvider.getLastSession() {
//                store.dispatch(LoadAuthAction(session: lastSession))
//                store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.search]))
//                return nil
//            }
            
//            LoginProvider.loginWithTwitter(completion: { session, error in
//                if error != nil {
//                    store.dispatch(ErrorAuthAction(error: error! as NSError))
//                } else if session != nil {
//                    store.dispatch(LoadAuthAction(session: session!))
//                    store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.search]))
//                }
//            })
            
            return nil
        }
    }
}

struct LoadAuthAction: Action {
    let session: TWTRAuthSession
}

struct ErrorAuthAction: Action {
    let error: NSError
}
