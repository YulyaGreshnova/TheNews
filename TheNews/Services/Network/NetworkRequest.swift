//
//  NetworkRequest.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 12.09.2022.
//

import Foundation

protocol INetworkRequest: AnyObject {
    var urlRequest: URLRequest? { get }
}

final class NetworkRequest: INetworkRequest {
    private let page: Int
    private let perPage: Int
    
    lazy var urlRequest: URLRequest? = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "pageSize", value: String(perPage)),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: "ea9a3932e9424c139e1a24b8d108ec66")
        ]
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }()
    
    init(page: Int, perPage: Int) {
        self.page = page
        self.perPage = perPage
    }
}
