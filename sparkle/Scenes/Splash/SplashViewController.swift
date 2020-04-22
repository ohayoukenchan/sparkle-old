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

class SplashViewController: UIViewController, StoreSubscriber, Routable {
    @IBOutlet weak var dummyButton: UILabel!

    @IBOutlet weak var fooButton: UIButton!

    private let disposeBag = DisposeBag()

    typealias StoreSubscriberStateType = AuthState
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.authState
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        fooButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
            print("HOOOOOOOO")
            store.dispatch(SplashState.routesChange())
        }).disposed(by: self.disposeBag)
//        if store.state.authState.loggedInState == .idle {
//            store.dispatch(AuthState.authenticateUser())

//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: AuthState) {
        if state.loggedInState == .notLoggedIn {
            
            let alert = UIAlertController(title: "Error", message: state.error!.localizedDescription, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { _ in
                store.dispatch(AuthState.authenticateUser())
            }))
            
            present(alert, animated: true)
        }
    }
}
