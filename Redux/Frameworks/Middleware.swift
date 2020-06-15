//
//  Middleware.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/10.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk
import SparkleClient
import RxSwift
import KeychainAccess
import API

//////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Thunk
//////////////////////////////////////////////////////////////////////////////////////////
public let thunkMiddleware: ReSwift.Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? ThunkAction {
                action.single
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: {
                        next($0)
                    })
                    .disposed(by: action.disposeBag)
            } else {
                return next(action)
            }
        }
    }
}

public let thunkStateMapMiddleware: ReSwift.Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
          if let s = action as? StateMapAction, let action = s.originalAction as? ThunkAction {
                action.single
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: {
                        next(StateMapAction(s.stateIdentifier, action: $0))
                    })
                    .disposed(by: action.disposeBag)
            } else {
                return next(action)
            }
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// MARK: - For Debug
//////////////////////////////////////////////////////////////////////////////////////////
#if DEBUG
public let debugLoggingMiddleware: ReSwift.Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? ThunkAction {
                // Do nothing
            } else {
                logger.info("\n🔥 [Action] \(String(describing: action))")
            }
            return next(action)
        }
    }
}

public let debugDelayRequestMiddleware: ReSwift.Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? ThunkAction {
                let single = action.single.delaySubscription(0.5, scheduler: MainScheduler.instance)
                let singleAction = ThunkAction(
                                        single, disposeBag:
                                        action.disposeBag,
                                        file: action.file,
                                        function: action.function
                                    )
                return next(singleAction)
            } else {
                return next(action)
            }
        }
    }
}
#endif


let fetch = Thunk<AppState> { dispatch, getState in
    dispatch(Requesting())
    BooksAPI.getBooksGet().subscribe(onNext: {
        (response) in
        print(response)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            dispatch(RequestBookSearchSuccess(response: response))
            dispatch(RequestSuccess())
        }
    },onError: {(error) in
        dispatch(RequestBookSearchError())
    })
}
