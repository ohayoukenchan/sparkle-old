//
//  SearchBooksReducer.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/10.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import ReSwift

func searchBooksReducer(action: Action, state: SearchBooksState?) -> SearchBooksState {
    var state = state ?? SearchBooksState()

    switch action {
    case let action as RequestBookSearchSuccess:
        state.books = action.response
    default:
        break
    }
    return state
}
