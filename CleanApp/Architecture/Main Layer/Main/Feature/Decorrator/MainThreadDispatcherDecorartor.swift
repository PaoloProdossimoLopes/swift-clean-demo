//
//  MainThreadDispatcherDecorartor.swift
//  Main
//
//  Created by Paolo Prodossimo Lopes on 20/07/22.
//

import Foundation
import Domain

final class MainThreadDispatcherDecorator<T> {
    
    private let instance: T
    
    init(_ instance: T) {
        self.instance = instance
    }
    
    private func dispach(_ completion: @escaping (() -> Void)) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainThreadDispatcherDecorator: AddAccount where T: AddAccount {
    func add(model: AddAccountModel, _ completion: @escaping AddCompletionBlock) {
        instance.add(model: model) { [weak self] result in
            guard let self = self else { return }
            self.dispach { completion(result) }
        }
    }
}
