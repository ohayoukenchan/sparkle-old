//
//  Errors.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/18.
//  Copyright © 2018 Takano Kenta. All rights reserved.
//

import Foundation

enum TwitterAPIError: Error {
    case somethingWentWrong(String)
}
