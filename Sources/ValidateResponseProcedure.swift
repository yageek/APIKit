//
//  ValidateResponseProcedure.swift
//  APIKit
//
//  Created by Yannick Heinrich on 15.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import ProcedureKit
import ProcedureKitNetwork

public protocol RequestValidation {
    func validResponse(response: HTTPURLResponse) throws
}

public struct DefaultValidation: RequestValidation {

    public func validResponse(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200..<299:
            break
        default:
            throw APIKitError.invalidHTTPCode
        }
    }
}

final class ValidateResponseProcedure<Payload: Equatable>: Procedure, InputProcedure, OutputProcedure {

    var input: Pending<HTTPPayloadResponse<Payload>> = .pending
    var output: Pending<ProcedureResult<Payload?>> = .pending

    let validation: RequestValidation
    init(validation: RequestValidation) {
        self.validation = validation
        super.init()
    }

    override func execute() {
        guard let input = input.value else {
            self.finish(withError: ProcedureKitError.dependenciesFailed())
            return
        }

        do {
            try self.validation.validResponse(response: input.response)
            self.finish()
        } catch let error {
            self.finish(withError: error)
        }
    }
}
