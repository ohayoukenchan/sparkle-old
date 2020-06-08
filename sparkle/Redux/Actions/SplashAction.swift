//
//  SplashAction.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/04/22.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import ReSwift
import ReSwiftRouter

extension SplashState {

    public static func routesChange() -> Store<AppState>.ActionCreator {
        return { state, store in
            store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.search]))

            return nil
        }
    }
}
