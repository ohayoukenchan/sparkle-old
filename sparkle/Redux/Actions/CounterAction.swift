//
//  ExampleAction.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/08.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import ReSwift

//struct ExampleAction: Action {
//    let counter: Counter?
//}
extension CounterState {

    public static func counterActionIncrease() -> Store<AppState>.ActionCreator {
        return { state, store in
            store.dispatch(CounterActionIncreaseAction())

            return nil
        }
    }

    public static func counterActionDecrease() -> Store<AppState>.ActionCreator {
    return { state, store in
        store.dispatch(CounterActionDecreaseAction())

        return nil
    }

    }
}

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}
struct CounterActionIncreaseAction: Action {}
struct CounterActionDecreaseAction: Action {}
//Actions
//struct SearchTweetsActionsAction: Action {
//    let query: String
//    let results: Result<[Tweet], TwitterAPIError>
//    let maxId: String?
//}
//
//struct LoadMoreTweetsAction: Action {
//    let results: Result<[Tweet], TwitterAPIError>
//    let maxId: String?
//}
//
//struct ResetSearchAction: Action {}
