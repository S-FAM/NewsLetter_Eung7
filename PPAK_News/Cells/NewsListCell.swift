//
//  NewsListCell.swift
//  PPAK_News
//
//  Created by 김응철 on 2022/06/06.
//

import UIKit
import SnapKit
import Kingfisher

class NewsListCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "NewsListCell"
    
    let thumbnail: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let descritpionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        [ thumbnail, titleLabel, descritpionLabel, dateLabel ]
            .forEach { contentView.addSubview($0) }
    }
}
