//
//  MovieTableViewCell.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import UIKit
import SDWebImage
import RandomColorSwift

class MovieTableViewCell: UITableViewCell {
    
    enum Constants {
        static let reuseIdentifier: String = "MovieTableViewCell"
        static let margin: CGFloat = 24
        static let placeHolder: String = "placeholder"
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var genreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var shortDescreptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
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
    
    lazy var containerView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let sView = UIStackView()
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        sView.alignment = .top
        sView.spacing = 4
        return sView
    }()
    
    let color = randomColor(hue: .orange, luminosity: .dark)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String {
        return Constants.reuseIdentifier
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: Setup
    private func setup() {
        setupContainerView()
        setupAvatar()
        setupPriceLabel()
        setupStackView()
    }
    
    //MARK: Setup Container View
    private func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(Constants.margin)
            make.trailing.equalToSuperview().offset(-Constants.margin)
            make.top.equalToSuperview().offset(12).priority(999)
            make.bottom.equalToSuperview().priority(999)
        }
        
        containerView.backgroundColor = color
    }
    
    //MARK: Setup Price Label
    private func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(Constants.margin)
            make.top.equalTo(avatarImageView.snp.bottom).offset(6)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
    }
    
    //MARK: Setup Avatar
    private func setupAvatar() {
        containerView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(Constants.margin)
            make.top.equalToSuperview().offset(Constants.margin)
            make.width.equalTo(50)
            make.height.equalTo(70)
        }
    }
    
    //MARK: Setup Stack View
    private func setupStackView() {
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.avatarImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(Constants.margin)
            make.trailing.equalToSuperview().offset(-12)
            make.height.greaterThanOrEqualTo(100)
            make.bottom.equalToSuperview().offset(-Constants.margin)
        }
        
        stackView.addArrangedSubview(self.nameLabel)
        stackView.addArrangedSubview(self.genreLabel)
        stackView.addArrangedSubview(self.shortDescreptionLabel)
    }
    
    //MARK: Bind Movie
    /// Bind Movie
    ///
    /// - Parameters:
    ///     - movie: Movie that will be displayed in the cell
    func bind(_ movie: Movie) {
        avatarImageView.sd_setImage(with: movie.artworkUrl60.toUrl, placeholderImage: UIImage(named: Constants.placeHolder))
        nameLabel.text = movie.trackName
        genreLabel.text = movie.primaryGenreName
        priceLabel.text = movie.trackPrice.toCurrency
        shortDescreptionLabel.text = movie.shortDescription
        stackView.layoutIfNeeded()
    }
    
}
