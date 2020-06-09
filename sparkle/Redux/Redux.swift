//
//  Redux.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()

// Note that it can perfectly live with other middleware in the chain.
let store = Store<AppState>(reducer: appReducer, state: nil, middleware: [thunkMiddleware])
