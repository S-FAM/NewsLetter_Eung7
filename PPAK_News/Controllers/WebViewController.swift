//
//  WebViewController.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/15.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    // MARK: - States
    let urlRequest: URLRequest
    let news: MyNews
    let bookmarkCenter = BookmarkCenter.shared
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    let webView = WKWebView()
    
    // MARK: - Life Cycle
    init(request: URLRequest, news: MyNews) {
        self.urlRequest = request
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBookmark()
        configureUI()
        configureURL(urlRequest)
    }
    
    // MARK: - Selectors
    @objc func didTapBookmarkButton() {
        bookmarkButton.isSelected = !bookmarkButton.isSelected
        if bookmarkButton.isSelected {
            bookmarkCenter.createMyNews(news)
        } else {
            bookmarkCenter.removeMyNews(news)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bookmarkButton)
        
        view.backgroundColor = .systemPink
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureURL(_ request: URLRequest) {
        webView.load(request)
    }
    
    func verifyBookmark() {
        if bookmarkCenter.verifyBookmark(news) {
            self.bookmarkButton.isSelected = true
        } else {
            self.bookmarkButton.isSelected = false
        }
    }
}
