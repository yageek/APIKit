//
//  UnmarshallProcedure.swift
//  APIKit
//
//  Created by Yannick Heinrich on 15.03.17.
//  Copyright © 2017 yageek. All rights reserved.
//

import ProcedureKit

final class UnmarshallProcedure<U: Unmarshaller, T: Unmarshable>: Procedure, InputProcedure, OutputProcedure where U.RepresentationValue == T.RepresentationValue {

    var input: Pending<Data> = .pending
    var output: Pending<ProcedureResult<T>> = .pending

    private let unmarshaller: U

    init(unmarshaller: U) {
        self.unmarshaller = unmarshaller
        super.init()
    }

    override func execute() {

        guard let data = self.input.value else {
            self.finish(withError: ProcedureKitError.dependenciesFailed())
            return
        }
        do {
            let rawValue = try unmarshaller.unmarshal(data: data)
            guard let finalObject = T(rawValue: rawValue) else {
                self.finish(withError: APIKitError.unmarshallingError)
                return
            }
            self.finish(withResult: .success(finalObject))

        } catch let error {
            self.finish(withError: error)
        }
    }
}

final class UnmarshallStreamProcedure<U: UnmarshallerStream, T: Unmarshable>: Procedure, InputProcedure, OutputProcedure where U.RepresentationValue == T.RepresentationValue {

    var input: Pending<URL> = .pending
    var output: Pending<ProcedureResult<T>> = .pending

    private let unmarshaller: U

    init(unmarshaller: U) {
        self.unmarshaller = unmarshaller
        super.init()
    }

    override func execute() {

        guard let url = self.input.value else {
            self.finish(withError: ProcedureKitError.dependenciesFailed())
            return
        }

        guard let stream = InputStream(url: url) else {
            self.finish(withError: ProcedureKitError.dependenciesFailed())
            return
        }

        stream.open()

        defer {
            stream.close()
        }
        do {
            let rawValue = try unmarshaller.unmarshal(stream: stream)
            guard let finalObject = T(rawValue: rawValue) else {
                self.finish(withError: APIKitError.unmarshallingError)
                return
            }
            self.finish(withResult: .success(finalObject))

        } catch let error {
            self.finish(withError: error)
        }
    }
}
