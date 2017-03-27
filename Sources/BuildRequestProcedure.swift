//
//  BuildRequestProcedure.swift
//  APIKit
//
//  Created by Yannick Heinrich on 01.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import ProcedureKit

class BuildRequestProcedure<E: Endpoint>: Procedure, OutputProcedure {
    public var endpoint: E
    public var output: Pending<ProcedureResult<URLRequest>>

    public init(endpoint: E) {
        self.endpoint = endpoint
        output = .pending

        super.init()
        name = "Build request for call: \(endpoint)"
    }

    public override func execute() {
        let callURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: callURL)
        request.httpMethod = endpoint.method

        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        output = .ready(.success(request))
        finish()
    }
}
