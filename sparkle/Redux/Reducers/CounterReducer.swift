//
//  CounterReducer.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/11/01.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift

func counterReducer(action: Action, state: CounterState?) -> CounterState {
    var state = state ?? CounterState()
    // 引数で受け取ったactionを判定し、処理を行う

    switch action {
    case let action as CounterActionIncreaseAction:
        state.counter += 1 // AppStateにはInt型の変数Counterを定義している
    case let action as CounterActionDecreaseAction:
        state.counter -= 1
    default:
        break
    }
    return state
}
