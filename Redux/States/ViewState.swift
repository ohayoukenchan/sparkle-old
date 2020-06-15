//
//  ViewState.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/09.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import RxCocoa

struct ViewState: StateType {
    //var session: TWTRAuthSession?
    //var error: NSError?
    var currentViewState: ViewTypes = .Blank
}

/**
 Viewの状態を扱うenum
 - .Working: 描画する要素があり、アプリが正常に動いている状態
 - .Blank: 描画する要素がない状態
 - .Requesting: 描画する要素を読み込んでいる状態
 - .Error(ErrorType): エラーが起きている状態
 */

enum ViewTypes {
    case Working
    case Blank
    case Requesting
    case Error(RequestErrorType)

    /**
     APIを叩いても良い状態かを判定
     */
    func fetchEnabled() -> Bool {
        switch self {
        case .Blank, .Working:
            return true
        default:
            return false
        }
    }
    mutating func refresh() {
        switch self {
        case .Error( _):
            self = .Blank
            break
        default:
            break
        }
    }
}

extension ViewTypes: CustomStringConvertible {
    var description: String {
        switch self {
        case .Working:
            return "working"
        case .Blank:
            return "blank"
        case .Requesting:
            return "requesting ..."
        case .Error:
            return "error"
        }
    }
}

extension Reactive where Base: UILabel {
    var viewTypes: Binder<ViewTypes> {
        return Binder(base) { label, result in
            //label.textColor = result.textColor
            label.text = result.description
        }
    }
}

/**
 続行可能かの状態を示す
 */
enum RequestErrorType: Error {
    case responseError(code: Int, msg: String?)
    case requestError(code: RequestErrorCode, msg: String?)
    case applicationError(code: Int, msg: String?)
}

enum RequestErrorCode: Int {
    // 通常リクエスト時の何らかのエラー用
    case normal = 100
    case cancel = 103
    case urlRequestCreate = 101
    case loginTypeCount = 105

    case loginError = 130
    case loginErrorByFacebook = 131
    case loginErrorByTwitter = 132
    case loginErrorByGoogle = 133
    case loginErrorByEmailAndPassword = 134
    case loginErrorByApple = 135

    case linkLoginError = 120

    case unlinkLoginError = 140
    case unlinkLoginErrorByFacebook = 141
    case unlinkLoginErrorByTwitter = 142
    case unlinkLoginErrorByGoogle = 143
    case unlinkLoginErrorByEmailAndPassword = 144

}
enum RequestActionMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}


/**
 API通信の状態を表現
 - .Stopped: API通信をまだ行っていない状態
 - .Requesting: API通信中
 - .Error(ErrorType): API通信でエラーが返ってきた状態
 - .Response(Decodable?): API通信でencode済みレスポンスを受け取っている
 */
//enum RequestState {
//    case Stopped
//    case Requesting
//    case Error(RequestErrorType)
//    case Response(Any?)
//}
