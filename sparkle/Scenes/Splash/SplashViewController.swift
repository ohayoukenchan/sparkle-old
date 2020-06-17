//
//  SplashViewController.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/03.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import UIKit
import TwitterKit
import ReSwift
import ReSwiftRouter
import RxSwift
import RxCocoa
import Redux
import SparkleClient
import SVProgressHUD


final class SplashViewController: UIViewController, HasWeakStateDisposeBag {
    let reduxStore: RxReduxStore
    let state: Observable<AuthenticationState>
    weak var weakStateDisposeBag: RxSwift.DisposeBag? // For HasWeakStateDisposeBag
    let label = UILabel()

    private let disposeBag = DisposeBag()

    init(reduxStore: RxReduxStore, state: Observable<AuthenticationState>, disposeBag: RxSwift.DisposeBag) {
        self.reduxStore = reduxStore
        self.state = state
        self.weakStateDisposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        initLog()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        deinitLog()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello World"
        label.textAlignment = .center
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        state.map { $0.isAuthenticated }
            .distinctUntilChanged()
            .bind(to: Binder(self) { $0.changeAuthenticated($1) })
            .disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = view.bounds
    }

    func changeAuthenticated(_ isAuthenticated: Bool) {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        let routingPage: Routing.Page = .bookSearch//isAuthenticated ? .main : .main
        let vc = Router.controller(reduxStore, routingPage: routingPage)
        addChildHelper(vc)
    }
}




//class SplashViewController: UIViewController, Routable {
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        //store.subscribe(self)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        fooButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            print("HOOOOOOOO")
//            //store.dispatch(SplashState.routesChange())
//        }).disposed(by: self.disposeBag)
//
//
//        counterUpButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            print("SSSSSSS")
//            //store.dispatch(increase)
//            //store.dispatch(CounterState.counterActionIncrease())
//        }).disposed(by: self.disposeBag)
//
//
//        counterDownButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
//            //store.dispatch(CounterState.counterActionDecrease())
//            //store.dispatch(decrease)
//        }).disposed(by: self.disposeBag)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        //store.unsubscribe(self)
//    }
//
//}
//
////extension SplashViewController: StoreSubscriber {
////
////    typealias StoreSubscriberStateType = AppState
////
////    func newState(state: AppState) {
////
////        switch state.viewState.currentViewState {
////            case .Requesting:
////                SVProgressHUD.sparkle.show()
////            case .Working:
////                SVProgressHUD.dismiss()
////            case .Blank:
////                print("aaa")
////            case .Error(_):
////                print("aaa")
////        }
////
////        if (state.searchBooksState.books.count > 0) {
////            currentViewStateLabel.text = state.searchBooksState.books[0].title
////        }
////        counterLabel.text = "\(state.counterState.counter)"
////    }
////}
