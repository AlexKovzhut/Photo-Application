//
//  TitleViewCell.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 10.12.2021.
//

import UIKit

class CollectionCell1: UICollectionViewCell {
    static let identifier = "CellID1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
