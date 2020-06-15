//
//  DumpState.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/11.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//
import Foundation

func dumpState<T>(_ value: T) -> String {
    var stream: String = .init()
    dump(value, to: &stream)
    return stream
}
