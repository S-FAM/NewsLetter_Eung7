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
    var viewModel: NewsTableViewModel?
    static let identifier = "NewsListCell"
    
    let thumbnail: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.kf.indicatorType = .activity
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 3
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .ultraLight)
        // TODO: [] DateFormatter 구현
        
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
        [ thumbnail, titleLabel, dateLabel ]
            .forEach { contentView.addSubview($0) }
        
        thumbnail.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(4)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalTo(thumbnail.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        thumbnail.kf.setImage(with: URL(string: viewModel.thumbnail), options: [.transition(.fade(0.3))])
    }
}
