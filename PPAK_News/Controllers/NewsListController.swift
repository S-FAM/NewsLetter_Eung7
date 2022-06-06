//
//  NewsListController.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import UIKit
import SnapKit

class NewsListController: UIViewController {
    // MARK: - States
    var isLoading: Bool = false
    
    // MARK: - Properties
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
        searchBar.searchTextField.textColor = .systemBackground
        searchBar.delegate = self
        
        return searchBar
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Git Test
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "PPAK News"
        navigationController?.view.backgroundColor = .systemTeal
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: querySearchBar)
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Selectors
}

// MARK: - TableViewDataSource
extension NewsListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.identifier,
                                                       for: indexPath) as? NewsListCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - TableViewDelegate
extension NewsListController: UITableViewDelegate {
    
}

// MARK: - SearchBarDelegate
extension NewsListController: UISearchBarDelegate {
}
