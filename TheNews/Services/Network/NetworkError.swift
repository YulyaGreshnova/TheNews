//
//  NetworkError.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 12.09.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serviceError
    case parserError
}
