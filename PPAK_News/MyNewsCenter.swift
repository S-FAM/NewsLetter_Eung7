//
//  MyNewsCenter.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation

class MyNewsCenter {
    static let shared = MyNewsCenter()
    
    var myNews: [MyNews] = []
}

extension MyNewsCenter {
    func createMyNews(_ news: News) {
        let myNews = MyNews(news: news, bookmark: true)
        self.myNews.insert(myNews, at: 0)
        saveNews()
    }
    
    func removeMyNews(_ news: News) {
        if let index = myNews.firstIndex(where: { $0.news.title == news.title }) {
            self.myNews.remove(at: index)
            saveNews()
        }
    }
}

extension MyNewsCenter {
    func saveNews() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(try? PropertyListEncoder().encode(myNews), forKey: "MyNews")
        userDefaults.synchronize()
    }
    
    func loadNews() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "MyNews") as? Data {
            do {
                myNews = try PropertyListDecoder().decode([MyNews].self, from: data)
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }
    }
}
