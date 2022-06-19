//
//  BookmarkViewController.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/19.
//

import UIKit
import SnapKit

class BookmarkViewController: UIViewController {
    // MARK: - Properties
    let center = BookmarkCenter.shared
    
    lazy var listView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.identifier)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listView.reloadData()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        listView.reloadData()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Bookmark"
        
        view.addSubview(listView)
        
        listView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableViewDataSource
extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return center.BookmarkNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListCell.identifier,
            for: indexPath
        ) as? NewsListCell else { return UITableViewCell() }
        let news = center.BookmarkNews[indexPath.row]
        let vm = NewsTableViewModel(news: news)
        cell.viewModel = vm
        cell.configureData()
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension BookmarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = center.BookmarkNews[indexPath.row]
        let newsURL = news.news.url
        if let url = URL(string: newsURL) {
            let request = URLRequest(url: url)
            let webVC = WebViewController(request: request, news: news)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
