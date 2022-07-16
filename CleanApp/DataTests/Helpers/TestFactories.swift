//
//  TestFactories.swift
//  DataTests
//
//  Created by Paolo Prodossimo Lopes on 16/07/22.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Paolo\"}".utf8)
}

func makeEmptyData() -> Data {
    Data()
}

func makeURL() -> URL {
    URL(string: "http://any-url.com")!
}

func makeError() -> Error {
    NSError(domain: "any_error", code: -1, userInfo: nil)
}

func makeHTTPResponse(_ status: Int = 200) -> HTTPURLResponse? {
    .init(url: makeURL(), statusCode: status, httpVersion: nil, headerFields: nil)
}
