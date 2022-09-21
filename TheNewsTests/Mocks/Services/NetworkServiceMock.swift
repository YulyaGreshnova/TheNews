//
//  NetworkServiceMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class NetworkServiceMock: INetworkService {
    var invokedFetchNews = false
    var invokedFetchNewsCount = 0
    var invokedFetchNewsParameters: (page: Int, perPage: Int)?
    var invokedFetchNewsParametersList = [(page: Int, perPage: Int)]()
    var stubbedFetchNewsCompletionResult: (Result<[NetworkNewsModel], NetworkError>, Void)?

    func fetchNews(page: Int,
        perPage: Int,
        completion: @escaping(Result<[NetworkNewsModel], NetworkError>) -> Void) {
        invokedFetchNews = true
        invokedFetchNewsCount += 1
        invokedFetchNewsParameters = (page, perPage)
        invokedFetchNewsParametersList.append((page, perPage))
        if let result = stubbedFetchNewsCompletionResult {
            completion(result.0)
        }
    }
}
