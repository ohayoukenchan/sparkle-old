//
//  Redux.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift

var store: Store<AppState> = Store<AppState>(reducer: appReducer, state: nil)
