//
//  ThirdCategorySectionView.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/25/25.
//

import UIKit

@MainActor
final class ThirdCategorySectionView: UIScrollView {
    
    // MARK: - Value
    // MARK: Public
    var animationRange = AnimationRange()
    
    // MARK: Private
    private var widthContraint: NSLayoutConstraint?
    private var heightContraint: NSLayoutConstraint?
    
    private var widthRange = AnimationRange()
    private var heightRange = AnimationRange()
    
    
    // MARK: - View
    // MARK: Private
    private lazy var contentView: UIView = {
        let view = UIView()
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: frameLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: frameLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor).isActive = true
        
        widthContraint = view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        widthContraint?.isActive = true
        
        return view
    }()
    
    private var views = [ThirdCategoryItemView]()
    
    
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
    func update(items: [ThirdCategoryItem]) {
        let item = Array(items.prefix(8))
        
        let result = item.count.quotientAndRemainder(dividingBy: 2)
        let row = result.quotient + result.remainder
        
        let screenWidth = UIScreen.main.bounds.width
        let startBound = screenWidth / 2 - 28
        let inset = screenWidth / 2 + 8

        let lastIndex = item.count - 1
        
        var leadingInset: CGFloat = 16
        
        item.enumerated().forEach { i, category in
            let view = ThirdCategoryItemView(item: category)
           
            contentView.addSubview(view)
            self.views.append(view)
            
            if row == 1 {
                view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingInset).isActive = true
                
                leadingInset += category.width + 16
                
                // Bottom
                guard i == lastIndex else { return }
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14).isActive = true
                
            } else {
                // Top
                var top: CGFloat {
                    switch i {
                    case 0, 1:  CGFloat(20)
                    default:    20 + CGFloat(34 * (i / 2))
                    }
                }
                
                view.topRange = AnimationRange(startBound: top, endBound: 16)
                
                view.topConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.topRange.startBound)
                view.topConstraint?.isActive = true
                
                // Leading
                let remainder = i % 2
                view.leadingRange = AnimationRange(startBound: remainder == 0 ? 20 : inset, endBound: leadingInset)
                view.leadingConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.leadingRange.startBound)
                view.leadingConstraint?.isActive = true
                
                leadingInset += category.width + 16
                
                
                // Width
                view.widthRange = AnimationRange(startBound: startBound, endBound: category.width)
                view.widthConstraint = view.widthAnchor.constraint(equalToConstant: view.widthRange.startBound)
                view.widthConstraint?.isActive = true
            }
        }
        
        widthRange = AnimationRange(startBound: screenWidth, endBound: max(screenWidth, leadingInset))
        heightRange = AnimationRange(startBound: CGFloat(row * 34 + 24), endBound: 48)
        
        heightContraint?.constant = heightRange.startBound
        
        layoutIfNeeded()
    }
    
    func handle(y: CGFloat) {
        let progress = max(0, min(1, (y - animationRange.startBound) / heightRange.startBound))  // 0 ~ Height
        views.forEach { $0.update(progress: progress) }
        
        widthContraint?.constant = widthRange.startBound + widthRange.length * progress
        heightContraint?.constant = heightRange.startBound + heightRange.length * progress
        
        layoutIfNeeded()
    }
    
    // MARK: Private
    private func setView() {
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        
        translatesAutoresizingMaskIntoConstraints = false
        
        heightContraint = heightAnchor.constraint(equalToConstant: 48)
        heightContraint?.isActive = true
    }
}
 
