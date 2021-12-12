//
//  SearchPhotosCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 08.12.2021.
//

import UIKit

class CollectionCell2: UICollectionViewCell {
    static let identifier = "CellID2"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
