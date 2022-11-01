//
//  RandomPhotoCollectionViewCell.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/31.
//

import Foundation
import UIKit
import SnapKit

class RandomPhotoCollectionViewCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let urlImages: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        [descriptionLabel, urlImages].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    func setConstraints() {
        
        urlImages.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(urlImages.snp.width)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(urlImages.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
