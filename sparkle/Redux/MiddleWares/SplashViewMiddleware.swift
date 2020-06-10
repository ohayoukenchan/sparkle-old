//
//  SplashViewMiddleware.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/10.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk

let fetch = Thunk<AppState> { dispatch, getState in
//    if getState!.loading {
//        return
//    }
    print("HHHHHHHOOOOOOOOOOOOOOOOOBBBBBBB")
    dispatch(RequestSuccess())
//    api.getSomething() { something in
//        if something != nil {
//            dispatch(RequestSuccess(something))
//        } else {
//            dispatch(RequestError())
//        }
//    }
}
