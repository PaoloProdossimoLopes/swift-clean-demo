//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Paolo Prodossimo Lopes on 16/07/22.
//

import Foundation
import Data
import Alamofire

public final class AlamofireAdapter: HTTPPostClient {
    public func post(to url: URL, with data: Data?, _ completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        session
            .request(
                url,
                method: .post,
                parameters: handleDataToJson(data),
                encoding: JSONEncoding.default
            )
            .responseData { dataResponse in
                guard let response = dataResponse.response else {
                    completion(.failure(.noConnectivity))
                    return
                }
                
                switch dataResponse.result {
                case .failure:
                    completion(.failure(.noConnectivity))
                    
                case .success(let data):
                    
                    switch response.statusCode {
                    case 204:
                        completion(.success(nil))
                        
                    case 200 ... 299:
                        completion(.success(data))
                        
                    case 401:
                        completion(.failure(.anauthorized))
                        
                    case 403:
                        completion(.failure(.forbidden))
                        
                    case 400 ... 499:
                        completion(.failure(.badRequest))
                        
                    case 500 ... 599:
                        completion(.failure(.serverError))
                        
                    default:
                        completion(.failure(.noConnectivity))
                    }
                }
            }
    }
    
    
    private var session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    private func handleDataToJson(_ data: Data?) -> [String: Any]? {
        guard let  data = data else { return nil }
        let jsonSerialized = try? JSONSerialization
            .jsonObject(with: data, options: .fragmentsAllowed)
        let json = jsonSerialized as? [String: Any]
        return json
    }
}
