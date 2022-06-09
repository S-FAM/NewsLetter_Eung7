//
//  NewsListViewModel.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/09.
//

import Foundation

struct NewsListViewModel {
    var news: [News] = []
}

extension NewsListViewModel {
    func numberOfRowsInSection() -> Int {
        return news.count
    }
    
    func getNewsFromIndex(_ index: Int) -> News {
        return news[index]
    }
}

struct NewsTableViewModel {
    var news: News 
}

extension NewsTableViewModel {
    var title: String { return news.title }
    var description: String { return news.description }
    var date: String { return news.publishedAt }
    var thumbnail: String { return news.urlToImage }
}

