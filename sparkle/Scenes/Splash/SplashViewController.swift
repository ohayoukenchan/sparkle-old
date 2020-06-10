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
import SparkleClient

class SplashViewController: UIViewController, Routable {

    @IBOutlet weak var dummyButton: UILabel!

    @IBOutlet weak var fooButton: UIButton!

    @IBOutlet weak var counterUpButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!

    @IBOutlet weak var counterDownButton: UIButton!
    @IBOutlet weak var currentViewStateLabel: UILabel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
        store.dispatch(fetch)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        BooksAPI.getBooksGet().subscribe(onNext: {
        (response) in
            print(response)
        },
        onError: {(error) in
            print("ssssss")
        })

        fooButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
            print("HOOOOOOOO")
            store.dispatch(SplashState.routesChange())
        }).disposed(by: self.disposeBag)


        counterUpButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
            print("SSSSSSS")
            store.dispatch(increase)
            //store.dispatch(CounterState.counterActionIncrease())
        }).disposed(by: self.disposeBag)


        counterDownButton.rx.tap.asDriver().drive(onNext: { [weak self]() in
            //store.dispatch(CounterState.counterActionDecrease())
            store.dispatch(decrease)
        }).disposed(by: self.disposeBag)    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }

}

extension SplashViewController: StoreSubscriber {

    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {

        currentViewStateLabel.text = "\(state.viewState.currentViewState.description)"
        counterLabel.text = "\(state.counterState.counter)"
    }
}
