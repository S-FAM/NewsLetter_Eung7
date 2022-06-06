//
//  News.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import UIKit

struct NewsResponseModel: Codable {
    let articles: [News]
}

struct News: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let url: String
    let content: String
    let publishedAt: String
}

