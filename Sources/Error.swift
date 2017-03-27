//
//  Error.swift
//  APIKit
//
//  Created by Yannick Heinrich on 27.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import Foundation

public enum APIKitError: Error {
    case invalidHTTPCode
    case unmarshallingError
}
