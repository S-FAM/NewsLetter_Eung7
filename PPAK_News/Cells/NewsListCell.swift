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
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let descritpionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        
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
        
        thumbnail.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(4)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.top)
            make.leading.equalTo(thumbnail.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
        }
        
        descritpionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descritpionLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        descritpionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        thumbnail.kf.setImage(with: URL(string: viewModel.thumbnail))
    }
}
