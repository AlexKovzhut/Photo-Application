//
//  TitleViewCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 10.12.2021.
//

import UIKit
import SDWebImage

class TitleViewCell: UICollectionViewCell {
    static let identifier = "TitleViewCell"
    
    private var imageView = UIImageView()
    private var label = UILabel()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls["full"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - UI

extension TitleViewCell {
    private func setup() {
        
    }
    
    private func setStyle() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creator"
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
}
