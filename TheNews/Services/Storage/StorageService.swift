//
//  StorageService.swift
//  TheNews
//
//  Created by Yulya Greshnova on 13.09.2022.
//

import Foundation

protocol IStorageService: AnyObject {
    func save(newsModels: [NewsModel], completion: @escaping(Bool) -> Void)
    func loadNews(completion: @escaping(Result<[NewsModel], Error>) -> Void)
}

final class StorageService: IStorageService {
    private let userDefaults = UserDefaults()
    private let queue = DispatchQueue.global(qos: .userInitiated)
    
    private struct Constants {
        static let key = "news"
    }
    
    func save(newsModels: [NewsModel], completion: @escaping(Bool) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            if let savedNews = try? JSONEncoder().encode(newsModels) {
                self.userDefaults.setValue(savedNews, forKey: Constants.key)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func loadNews(completion: @escaping(Result<[NewsModel], Error>) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            do {
                if let savedData = self.userDefaults.object(forKey: Constants.key) as? Data {
                    let loadNews = try JSONDecoder().decode([NewsModel].self, from: savedData)
                    completion(.success(loadNews))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
