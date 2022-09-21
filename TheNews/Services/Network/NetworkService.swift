//
//  NetworkService.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 12.09.2022.
//

import Foundation

protocol INetworkService: AnyObject {
    func fetchNews(page: Int,
                   perPage: Int,
                   completion: @escaping(Result<[NetworkNewsModel], NetworkError>) -> Void)
}

final class NetworkService: INetworkService {
    private let session = URLSession.shared
    
    func fetchNews(page: Int,
                   perPage: Int,
                   completion: @escaping(Result<[NetworkNewsModel], NetworkError>) -> Void) {
        
        guard let request = NetworkRequest(page: page, perPage: perPage).urlRequest else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            guard error == nil else {
                completion(.failure(NetworkError.serviceError))
                return
            }
            
            guard let data = data,
               let response = urlResponse as? HTTPURLResponse,
               response.statusCode == 200 else {
                completion(.failure(NetworkError.serviceError))
                return
            }
            
            do {
                let decode = JSONDecoder()
                decode.dateDecodingStrategy = .iso8601
                let newsData = try decode.decode(ResponseNewsModel.self, from: data)
                completion(.success(newsData.articles))
            } catch {
                completion(.failure(NetworkError.parserError))
            }
        }
        task.resume()
    }
}
