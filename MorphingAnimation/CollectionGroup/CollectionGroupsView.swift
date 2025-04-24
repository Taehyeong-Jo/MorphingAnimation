//
//  CollectionGroupsView.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/24/25.
//

import UIKit

final class CollectionGroupsView: UIScrollView {
    
    // MARK: - Value
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
        
        let widthAchor = stackView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor)
        widthAchor.priority = .defaultLow
        widthAchor.isActive = true

        stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        stackView.setContentHuggingPriority(.required, for: .vertical)
        
        return stackView
    }()
    
    private var buttons = [CollectionGroupButton]()
    
    
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
    func update(groups: [CollectionGroup]) {
        groups.forEach {
            let button = CollectionGroupButton(data: $0)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    func handle(y: CGFloat) {
        let progress = max(0, min(1, y / 66))   // 0 ~ 66
        
        heightContraint?.constant = 118 - 66 * progress
        buttons.forEach { $0.update(progress: progress) }
        
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
 
