//
//  NewsListViewModel.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation
import UIKit

struct NewsListViewModel: Codable {
    let title: String
    let date: Date
    let source: String
    let url: String?
    let description: String
    let urlSource: String
    var viewCount: Int = 0
}
