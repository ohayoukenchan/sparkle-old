//
//  SVProgressHUD.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/10.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//
import SVProgressHUD

public extension SVProgressHUD {
    struct sparkle {
        // プロジェクト固有の初期設定
        public static func setup() {
//            SVProgressHUD.setDefaultStyle(.custom)
//            SVProgressHUD.setFont(UIFont.boldSystemFont(ofSize: 14.0))
//            SVProgressHUD.setForegroundColor(UIColor.iq.pink)
//            SVProgressHUD.setBackgroundColor(UIColor.white.withAlphaComponent(0.9))
            SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        }
        public static func show(maskType: SVProgressHUDMaskType = .none) {
            SVProgressHUD.setDefaultMaskType(maskType)
            SVProgressHUD.show()
        }
    }
}
