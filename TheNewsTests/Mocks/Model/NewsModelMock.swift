//
//  NewsModelMock.swift
//  TheNewsTests
//
//  Created by Yulya Greshnova on 19.09.2022.
//

@testable import TheNews
import Foundation

struct NewsModelMock {
    var newsModel = NewsModel(title: "foo",
                              date: Date(),
                              source: "foo",
                              url: "foo",
                              imageUrl: nil,
                              description: "foo")
}
