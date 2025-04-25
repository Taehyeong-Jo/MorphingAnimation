//
//  CollectionGroupsSectionView.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/24/25.
//

import UIKit

@MainActor
final class CollectionGroupsSectionView: UIScrollView {
    
    // MARK: - Value
    // MARK: Public
    var animationRange = AnimationRange()
    
    // MARK: Private
    private var heightContraint: NSLayoutConstraint?
    
    
    // MARK: - View
    // MARK: Private
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: frameLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: frameLayoutGuide.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: frameLayoutGuide.widthAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        stackView.setContentHuggingPriority(.required, for: .vertical)
        
        return stackView
    }()
    
    private var views = [CollectionGroupItemView]()
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    
    // MARK: - Function
    // MARK: Public
    func update(items: [CollectionGroupItem]) {
        items.forEach {
            let view = CollectionGroupItemView(item: $0)
            views.append(view)
            stackView.addArrangedSubview(view)
        }
    }
    
    func handle(y: CGFloat) {
        let progress = max(0, min(1, (y - animationRange.startBound) / 66))   // 0 ~ 66
        
        heightContraint?.constant = 118 - 66 * progress
        views.forEach { $0.update(progress: progress) }
        
        layoutIfNeeded()
    }
    
    // MARK: Private
    private func setView() {
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        
        translatesAutoresizingMaskIntoConstraints = false
        
        heightContraint = heightAnchor.constraint(equalToConstant: 118)
        heightContraint?.isActive = true
    }
}
