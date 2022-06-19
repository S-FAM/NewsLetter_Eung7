//
//  TabBarController.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/19.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    let newsListVC = NewsListController()
    let bookmarkVC = BookmarkViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .systemPink
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = .systemPink
        
        newsListVC.tabBarItem = UITabBarItem(title: "뉴스", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        bookmarkVC.tabBarItem = UITabBarItem(title: "북마크", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        
        let newsNavVC = UINavigationController(rootViewController: newsListVC)
        let bookmarkNavVC = UINavigationController(rootViewController: bookmarkVC)
        
        viewControllers = [ newsNavVC, bookmarkNavVC ]
    }
}
