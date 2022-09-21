//
//  NewsModel.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation

struct NewsModel: Codable {
    let title: String
    let date: Date
    let source: String
    let url: String
    let imageUrl: String?
    let description: String
    var viewCount = 0
}
