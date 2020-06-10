//
//  ViewReducer.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/09.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import ReSwift

func viewReducer(action: Action, state: ViewState?) -> ViewState {
    var state = state ?? ViewState()

    switch action {
    case _ as RequestSuccess:
        state.currentViewState = .Requesting
    default:
        break
    }
    return state
}
