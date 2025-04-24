//
//  ThirdCategoryItemView.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/23/25.
//

import UIKit

final class ThirdCategoryItemView: UIControl {
    
    // MARK: - View
    // MARK: Private
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }()
    
    
    // MARK: - Value
    // MARK: Public
    private(set) var width: CGFloat = 0
    
    var topRange = ThirdCategoryRange()
    var bottomRange = ThirdCategoryRange()
    var leadingRange = ThirdCategoryRange()
    var trailingRange = ThirdCategoryRange()
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    
    // MARK: - Initializer
    required init(item: ThirdCategoryItem) {
        super.init(frame: .zero)
        
        setView()
        update(item: item)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    
    // MARK: - Function
    // MARK: Public
    func update(item: ThirdCategoryItem) {
        label.text = item.name
        label.font = item.font
        label.textColor = item.textColor
        
        guard width == 0 else { return }
        width = item.width
    }
    
    func update(progress: CGFloat) {
        topConstraint?.constant = topRange.startBound - topRange.length * progress
        bottomConstraint?.constant = bottomRange.startBound - bottomRange.length * progress
        leadingConstraint?.constant = leadingRange.startBound - leadingRange.length * progress
        trailingConstraint?.constant = trailingRange.startBound - trailingRange.length * progress
    }
    
    // MARK: Private
    private func setView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
