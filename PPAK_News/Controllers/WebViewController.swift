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
    
    // MARK: - Properties
    let webView = WKWebView()
    
    // MARK: - Life Cycle
    init(request: URLRequest) {
        self.urlRequest = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureURL(urlRequest)
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .systemPink
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureURL(_ request: URLRequest) {
        webView.load(request)
    }
}
