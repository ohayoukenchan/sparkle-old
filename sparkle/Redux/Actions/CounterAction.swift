//
//  ExampleAction.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/08.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let increase = Thunk<AppState> { dispatch, getState in
//    if getState!.loading {
//        return
//    }
    print("HHHHHHHOOOOOOOOOOOOOOOOOBBBBBBB")
    dispatch(CounterActionIncreaseAction())
//    api.getSomething() { something in
//        if something != nil {
//            dispatch(RequestSuccess(something))
//        } else {
//            dispatch(RequestError())
//        }
//    }
}

let decrease = Thunk<AppState> { dispatch, getState in

    dispatch(CounterActionDecreaseAction())
}

struct CounterActionIncreaseAction: Action {}
struct CounterActionDecreaseAction: Action {}
