//
//  Service.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import Alamofire
import Foundation

class NewsService {
    static func fetchNews(_ query: String, page: Int, completion: @escaping (([News], Int) -> Void)) {
        let url = URL(string: "https://newsapi.org/v2/everything")!
        let parameters: [String: Any] = [
            "q": query,
            "apiKey": "6f5c1f24201d4a6681ef1da3e41810e9",
            "pageSize": 10,
            "page": page
        ]
        
        AF
            .request(url, method: .get, parameters: parameters)
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let responseModel):
                    DispatchQueue.main.async {
                        completion(responseModel.articles, page + 1)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
