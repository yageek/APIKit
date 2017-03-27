//
//  Endpoint.swift
//  APIKit
//
//  Created by Yannick Heinrich on 01.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import Foundation

/// Endpoint represents an HTTP endpoint.
public protocol Endpoint {

    /// The baseURL of the endpoint. Ex: http://www.google.fr
    var baseURL: URL { get }

    /// The parameters for the endpoint. Ex: ["q":"search"]
    var parameters: [String: Any] { get }

    /// The path for the endpoint. Ex: /search
    var path: String { get }

    /// The method of the endpoint. Ex: GET, POST, PUT
    var method: String { get }

    /// The headers of the endpoints.
    var headers: [String: String] { get }
}

/// Resource represent the payload of an Endpoint
///
/// - none: No object for this endoint
/// - single: A single object for the endpoint
/// - collection: A collection of object for the endpoint.
public enum Resource<T> {
    case none
    case single(T)
    case collection([T])
}
