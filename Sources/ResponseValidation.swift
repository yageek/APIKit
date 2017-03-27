//
//  ResponseValidation.swift
//  APIKit
//
//  Created by Yannick Heinrich on 15.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import Foundation
protocol ResponseValidation {
    associatedtype Payload: Equatable
    func validateServerResponse(response: HTTPURLResponse, payload: Payload) -> Bool
}
