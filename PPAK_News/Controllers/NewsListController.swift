//
//  NewsListController.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import UIKit
import SnapKit
import WebKit

class NewsListController: UIViewController {
    // MARK: - States
    var isLoading: Bool = true
    var currentPage: Int = 1
    var currentQuery: String = ""
    
    // MARK: - Properties
    let viewModel = NewsListViewModel()
    
    lazy var listView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.identifier)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    lazy var querySearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        searchBar.placeholder = "What's your interests?"
        searchBar.returnKeyType = .search
        searchBar.tintColor = .systemBackground
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.searchTextField.textColor = .label
        searchBar.delegate = self
        
        return searchBar
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "PPAK News"
        navigationController?.view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: querySearchBar)
        
        view.addSubview(listView)
        
        listView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        querySearchBar.resignFirstResponder()
        if listView.contentOffset.y > (listView.contentSize.height - listView.bounds.size.height) {
            if !isLoading {
                isLoading = true
                NewsService.fetchNews(currentQuery, page: currentPage) { [weak self] news, nextPage in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.viewModel.appendNews(news)
                        self?.currentPage = nextPage
                        self?.isLoading = false
                        self?.listView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - TableViewDataSource
extension NewsListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListCell.identifier,
            for: indexPath
        ) as? NewsListCell else { return UITableViewCell() }
        let news = viewModel.getNewsFromIndex(indexPath.row)
        let vm = NewsTableViewModel(news: news)
        cell.viewModel = vm
        cell.configureData()
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension NewsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsURL = viewModel.getNewsFromIndex(indexPath.row).news.url
        let news = viewModel.getNewsFromIndex(indexPath.row)
        if let url = URL(string: newsURL) {
            let request = URLRequest(url: url)
            let webVC = WebViewController(request: request, news: news)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

// MARK: - SearchBarDelegate
extension NewsListController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isLoading = false
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isLoading = false
        guard let query = searchBar.searchTextField.text else { return }
        NewsService.fetchNews(query, page: 1) { [weak self] news, nextPage in
            self?.viewModel.initializeNews(news)
            self?.currentPage = nextPage
            self?.currentQuery = query
            self?.listView.reloadData()
        }
        searchBar.endEditing(true)
    }
}
