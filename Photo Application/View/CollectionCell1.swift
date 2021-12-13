//
//  TitleViewCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 10.12.2021.
//

import UIKit

class CollectionCell1: UICollectionViewCell {
    static let identifier = "CellID1"
    
    let imageView = UIImageView()
    let label = UILabel()
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.tintColor = .white
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)
        ])
    }
}
