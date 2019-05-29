//
//  RootRoutable.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/03.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//
import ReSwiftRouter

class RootRoutable: Routable {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setToSplashViewController() -> Routable {
        self.window.rootViewController = R.storyboard.splash.instantiateInitialViewController()
        
        return SplashViewRoutable()
    }
    
    
    func setToSearchViewController() -> Routable {
        self.window.rootViewController = R.storyboard.search.instantiateInitialViewController()
        
        return SearchViewRoutable(window.rootViewController!)
    }

    func changeRouteSegment(
        _ from: RouteElementIdentifier,
        to: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler
        ) -> Routable {
        
        if to == RouteNames.search {
            completionHandler()
            return setToSearchViewController()
        } else if to == RouteNames.splash {
            completionHandler()
            return setToSplashViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func pushRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler
        ) -> Routable {
        
        if routeElementIdentifier == RouteNames.search {
            completionHandler()
            return setToSearchViewController()
        } else if routeElementIdentifier == RouteNames.splash {
            completionHandler()
            return setToSplashViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
}

