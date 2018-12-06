//
//  ViewController.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/10/31.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet weak var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // subscribe to state changes
        //mainStore.subscribe(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newState(state: AppState) {
        // when the state changes, the UI is updated to reflect the current state
        // counterLabel.text = "\(mainStore.state.counter)"
    }
    
    // when either button is tapped, an action is dispatched to the store
    // in order to update the application state
//    @IBAction func downTouch(_ sender: AnyObject) {
//        mainStore.dispatch(CounterActionDecrease());
//    }
//    @IBAction func upTouch(_ sender: AnyObject) {
//        mainStore.dispatch(CounterActionIncrease());
//    }


}

