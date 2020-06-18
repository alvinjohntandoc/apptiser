//
//  MovieDetailsTableViewCell.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 18/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//

import UIKit
import SDWebImage
import RandomColorSwift

class MovieDetailsTableViewCell: UITableViewCell {
    
    enum Constants {
        static let reuseIdentifier: String = "MovieDetailsTableViewCell"
        static let margin: CGFloat = 24
    }
    
    lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let color = randomColor(hue: .random, luminosity: .random)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
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
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(0)
            make.leading.equalToSuperview().offset(Constants.margin)
            make.trailing.equalToSuperview().offset(-Constants.margin)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.margin)
        }
    }
    
    //MARK: Bind Movie
    /// Bind Movie
    ///
    /// - Parameters:
    ///     - movie: Movie that will be displaed in the cell, will display movie.longDescription
    func bind(_ movie: Movie) {
        let attributedString = NSMutableAttributedString(string: movie.longDescription ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        descriptionLabel.attributedText = attributedString
    }
    
}
