//
//  TitleViewCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 10.12.2021.
//

import UIKit
import SDWebImage

class CollectionCell1: UICollectionViewCell {
    static let identifier = "CellID1"
    
    let button = UIButton()
    var imageView = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil // image is reused
    }
    
    private func setStyle() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
    }
    
    private func setLayout() {
        contentView.addSubview(button)
        button.addSubview(imageView)
        button.addSubview(label)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)
        ])
    }
}
