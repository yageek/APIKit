//
//  JSON.swift
//  APIKit
//
//  Created by Yannick Heinrich on 01.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import Foundation

public struct JSON: Marshaller, UnmarshallerStream {
    public func unmarshal(stream: InputStream) throws -> Any {
        return try JSONSerialization.jsonObject(with: stream, options: [])
    }
    public func unmarshal(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: [])
    }

    public func marshal(value: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: value, options: [])
    }
}
