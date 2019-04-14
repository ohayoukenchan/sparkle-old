//
//  UIView+CornerRadius.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/18.
//  Copyright © 2018 Takano Kenta. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
