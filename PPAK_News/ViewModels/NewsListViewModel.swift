//
//  NewsListViewModel.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/09.
//

import Foundation

class NewsListViewModel {
    var news: [MyNews] = []
}

extension NewsListViewModel {
    
    
    func numberOfRowsInSection() -> Int {
        return news.count
    }
    
    func getNewsFromIndex(_ index: Int) -> MyNews {
        return news[index]
    }
    
    func appendNews(_ news: [News]) {
        _ = news.map {
            let myNews = MyNews(news: $0, bookmark: false)
            self.news.append(myNews)
        }
    }
    
    func initializeNews(_ news: [News]) {
        self.news = []
        _ = news.map {
            let myNews = MyNews(news: $0, bookmark: false)
            self.news.append(myNews)
        }
    }
}

struct NewsTableViewModel {
    let news: MyNews
}

extension NewsTableViewModel {
    var title: String { return news.news.title }
    var description: String { return news.news.description }
    var date: String { return news.news.publishedAt }
    var thumbnail: String { return news.news.urlToImage }
}

