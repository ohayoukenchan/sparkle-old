//
//  lookUpReducer.swift
//  sparkle
//
//  Created by Takano Kenta on 2019/04/21.
//  Copyright © 2019 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift

func lookUpReducer(action: Action, state: LookUpState?) -> LookUpState {
    var state = state ?? LookUpState(test: false)
    
    switch action {
    case _ as LookUpAction:
        state.test = false
    default:
        break
    }
    
    return state
}
