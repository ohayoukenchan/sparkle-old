//
//  Global.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/11.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//
import Foundation
import SwiftyBeaver

let logger = SwiftyBeaver.self

// swiftlint:disable identifier_name
let Unreachable = "UnreachableCode"
// swiftlint:enable identifier_name
// swiftlint:disable identifier_name

public func assertionFailureUnreachable() {
    // NOTE: If you want to send `assertionFailure` occurrence to the crashlytics etc,
    // please describe it here.
    assertionFailure(Unreachable)
}

