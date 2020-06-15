//
//  Helper.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/12.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//
import Foundation

extension NSObject {
    func initLog() {
        #if DEBUG
        logger.info("🏵🏵🏵 INIT \(self) 🏵🏵🏵")
        #endif
    }

    func deinitLog() {
        #if DEBUG
        logger.info("🎃🎃🎃 DEINIT \(self) 🎃🎃🎃")
        #endif
    }
}

