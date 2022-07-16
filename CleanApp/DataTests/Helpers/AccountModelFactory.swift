//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Paolo Prodossimo Lopes on 16/07/22.
//

import Domain

func makeAccountModel() -> AccountModel {
    return .init(
        id: "id", name: "any_name",
        email: "any_email@mail.com", password: "any_password"
    )
}
