//
//  StorageServiceMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews

class StorageServiceMock: IStorageService {
    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (newsModels: [NewsModel], Void)?
    var invokedSaveParametersList = [(newsModels: [NewsModel], Void)]()
    var stubbedSaveCompletionResult: (Bool, Void)?

    func save(newsModels: [NewsModel], completion: @escaping(Bool) -> Void) {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (newsModels, ())
        invokedSaveParametersList.append((newsModels, ()))
        if let result = stubbedSaveCompletionResult {
            completion(result.0)
        }
    }

    var invokedLoadNews = false
    var invokedLoadNewsCount = 0
    var stubbedLoadNewsCompletionResult: (Result<[NewsModel], Error>, Void)?

    func loadNews(completion: @escaping(Result<[NewsModel], Error>) -> Void) {
        invokedLoadNews = true
        invokedLoadNewsCount += 1
        if let result = stubbedLoadNewsCompletionResult {
            completion(result.0)
        }
    }
}
