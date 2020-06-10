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
import SparkleClient

let fetch = Thunk<AppState> { dispatch, getState in
    //    if getState!.loading {
    //        return
    //    }

    BooksAPI.getBooksGet().subscribe(onNext: {
    (response) in
        print(response)
        dispatch(RequestBookSearchSuccess(response: response))
    },
    onError: {(error) in
        dispatch(RequestBookSearchError())
    })
}
