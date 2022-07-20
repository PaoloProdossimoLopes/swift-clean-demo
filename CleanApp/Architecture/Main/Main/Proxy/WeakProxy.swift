//
//  WeakProxy.swift
//  Main
//
//  Created by Paolo Prodossimo Lopes on 20/07/22.
//

import Foundation
import Presentation

final class WeakProxy<T: AnyObject> {
    
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

//MARK: - AlertView
extension WeakProxy: AlertView where T: AlertView {
    func showMessage(model: AlertModel) {
        instance?.showMessage(model: model)
    }
}

//MARK: - LoadingView
extension WeakProxy: LoadingView where T: LoadingView {
    func display(isLoading: Bool) {
        instance?.display(isLoading: isLoading)
    }
}

//Adicionando o protocolo ao prozy
//Adicionando a condiçao de que o tipo do objeto tbm é da extensao para passar o comportamento da instancia que nao era weak
