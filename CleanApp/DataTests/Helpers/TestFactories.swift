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

func makeURL() -> URL {
    URL(string: "http://any-url.com")!
}
