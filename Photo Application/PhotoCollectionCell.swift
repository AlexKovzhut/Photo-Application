//
//  PhotoCollectionCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 08.12.2021.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    static let reuseId = "PhotosCell"
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "suit.heart.fill")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        
        return  imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
            
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7: 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        setupCheckmarkView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupCheckmarkView() {
        addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        checkmark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
