//
//  TitleElement.swift
//  Redux
//
//  Created by  ohayoukenchan on 2020/06/22.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation

public struct TitleElement: Diffable {
    public let identifier: Identifier
    public let title: String

    init(_ title: String) {
        self.title = title
        self.identifier = .init("\(String(describing: TitleElement.self))-\(title)")
    }

    public static func == (lhs: TitleElement, rhs: TitleElement) -> Bool {
        return lhs.title == rhs.title
    }
}
