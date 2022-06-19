//
//  MyNewsCenter.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation

class BookmarkCenter {
    static let shared = BookmarkCenter()
    var BookmarkNews: [MyNews] = []
}

extension BookmarkCenter {
    func createMyNews(_ news: MyNews) {
        let bookmark = MyNews(news: news.news, bookmark: true)
        self.BookmarkNews.insert(bookmark, at: 0)
        saveNews()
    }
    
    func removeMyNews(_ news: MyNews) {
        if let index = BookmarkNews.firstIndex(where: { $0.news.title == news.news.title }) {
            self.BookmarkNews[index].bookmark = false
            self.BookmarkNews.remove(at: index)
            saveNews()
        }
    }
    
    func verifyBookmark(_ news: MyNews) -> Bool {
        if BookmarkNews.contains(where: { $0.news.title == news.news.title }) {
            return true
        } else {
            return false
        }
    }
}

extension BookmarkCenter {
    func saveNews() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(try? PropertyListEncoder().encode(BookmarkNews), forKey: "MyNews")
        userDefaults.synchronize()
    }
    
    func loadNews() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "MyNews") as? Data {
            do {
                BookmarkNews = try PropertyListDecoder().decode([MyNews].self, from: data)
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }
    }
}
