//
//  NetworkNewsModel.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 12.09.2022.
//

import Foundation

struct NetworkNewsModel: Decodable {
    let title: String
    let urlToImage: String?
    let url: String
    let publishedAt: Date
    let description: String
    let sourceNews: String
    
    enum DecodingKeys: String, CodingKey {
        case title
        case urlToImage
        case url
        case publishedAt
        case description
        case source
    }
    
    enum SourceDecodingKeys: String, CodingKey{
        case sourceNews = "name"
    }
}

struct ResponseNewsModel: Decodable {
    let articles: [NetworkNewsModel]
}

extension NetworkNewsModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        urlToImage = try container.decode(String.self, forKey: .urlToImage)
        url = try container.decode(String.self, forKey: .url)
        publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        description = try container.decode(String.self, forKey: .description)
        
        let sourceContainer = try container.nestedContainer(keyedBy: SourceDecodingKeys.self, forKey: .source)
        sourceNews = try sourceContainer.decode(String.self, forKey: .sourceNews)
    }
}
