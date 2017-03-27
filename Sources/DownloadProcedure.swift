//
//  DownloadProcedure.swift
//  APIKit
//
//  Created by Yannick Heinrich on 16.11.16.
//  Copyright © 2016 Vitactiv. All rights reserved.
//

import ProcedureKit
import ProcedureKitNetwork

public final class DownloadProcedure<E: Endpoint, U: UnmarshallerStream, T: Unmarshable>: GroupProcedure, OutputProcedure where U.RepresentationValue == T.RepresentationValue {

    public var output: Pending<ProcedureResult<Resource<T>>> = .pending

    public init(session: URLSession, endpoint: E, unmarshaller: U, object: Resource<T> = .none, validation: RequestValidation = DefaultValidation()) {

        let serializedURLProcedure = BuildRequestProcedure(endpoint: endpoint)
        let downloadProcedure = NetworkDownloadProcedure(session: session).injectResult(from: serializedURLProcedure)
        let validateResponse = ValidateResponseProcedure<URL>(validation: validation).injectResult(from: downloadProcedure)

        // swiftlint:disable comma
        let unmarshallProcedure = UnmarshallStreamProcedure<U,T>(unmarshaller: unmarshaller).injectPayload(fromNetwork: downloadProcedure)
        // swiftlint:enable comma
        unmarshallProcedure.add(dependency: validateResponse)

        super.init(operations: [serializedURLProcedure, downloadProcedure, validateResponse, unmarshallProcedure])
     }
}

public final class DataProcedure<E: Endpoint, U: Unmarshaller, T: Unmarshable>: GroupProcedure, OutputProcedure where U.RepresentationValue == T.RepresentationValue {

    public var output: Pending<ProcedureResult<Resource<T>>> = .pending

    public init(session: URLSession, endpoint: E, unmarshaller: U, object: Resource<T> = .none, validation: RequestValidation = DefaultValidation()) {

        let serializedURLProcedure = BuildRequestProcedure(endpoint: endpoint)
        let downloadProcedure = NetworkDataProcedure(session: session).injectResult(from: serializedURLProcedure)
        let validateResponse = ValidateResponseProcedure<Data>(validation: validation).injectResult(from: downloadProcedure)

        // swiftlint:disable comma
        let unmarshallProcedure = UnmarshallProcedure<U,T>(unmarshaller: unmarshaller).injectPayload(fromNetwork: downloadProcedure)
        // swiftlint:enable comma
        unmarshallProcedure.add(dependency: validateResponse)

        super.init(operations: [serializedURLProcedure, downloadProcedure, validateResponse, unmarshallProcedure])
    }

}
