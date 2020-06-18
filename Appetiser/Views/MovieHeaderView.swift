//
//  MovieHeaderView.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 18/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import Foundation
import UIKit

class MovieHeaderView: UIView {
    
    lazy var stackView: UIStackView = {
        let sView = UIStackView()
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.alignment = .center
        sView.spacing = 12
        return sView
    }()
    
    
    lazy var avatarImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var genreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Bind Movie
    /// Bind Movie
    ///
    /// - Parameters:
    ///     - movie: Movie that will be displayed in the view
    init(movie: Movie) {
        super.init(frame: CGRect.zero)
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        avatarImageView.sd_setImage(with: movie.artworkUrl100.toUrl)
        
        nameLabel.text = movie.trackName
        genreLabel.text = movie.primaryGenreName
        
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(genreLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
