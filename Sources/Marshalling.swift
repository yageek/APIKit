//
//  Marshalling.swift
//  APIKit
//
//  Created by Yannick Heinrich on 01.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import Foundation

/// Marshaller is an object capable of 
/// transforming a Data type to a specified value.
public protocol Marshaller {
    associatedtype RepresentationValue
    func marshal(value: RepresentationValue) throws -> Data
}

/// Unmarshaller is an object capable of
/// transforming a specified value from a Data type.
public protocol Unmarshaller {
    associatedtype RepresentationValue
    func unmarshal(data: Data) throws -> RepresentationValue
}

/// UnmarshallerStream is an object capable of
/// transforming a specified value from a Stream type.
public protocol UnmarshallerStream {
     associatedtype RepresentationValue
     func unmarshal(stream: InputStream) throws -> RepresentationValue
}

public protocol MarshallerStream {
    associatedtype RepresentationValue
    func marshal(value: RepresentationValue, stream: OutputStream) throws
}

public protocol Marshable {
    associatedtype RepresentationValue
    var rawValue: RepresentationValue? { get }
}

public protocol Unmarshable {
    associatedtype RepresentationValue
    init?(rawValue: RepresentationValue)
}
