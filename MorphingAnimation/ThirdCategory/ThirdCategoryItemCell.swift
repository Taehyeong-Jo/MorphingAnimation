//
//  ThirdCategoryItemCell.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/23/25.
//

import UIKit

final class ThirdCategoryItemView: UIControl {
    
    // MARK: - Value
    // MARK: Public
    var item = ThirdCategoryItem()
    
    
    
    // MARK: - View
    // MARK: Private
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: item.fontWeight)
        label.textColor = item.textColor
        label.textAlignment = .left
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        return label
    }()
    
    
    // MARK: - Function
    // MARK: Public
    func update(item: ThirdCategoryItem) {
        label.text = item.name
    }
}
