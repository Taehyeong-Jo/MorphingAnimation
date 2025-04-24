//
//  ViewController.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/22/25.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - IBOutlet
    // MARK: Private
    @IBOutlet private var scrollView: UIScrollView!
    
    
    // MARK: - Value
    // MARK: Private
    private var heightContraint: NSLayoutConstraint?
    
    private lazy var thirdCategoriesView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: collectionGroupsView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        thirdCategoriesView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: thirdCategoriesView.frameLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: thirdCategoriesView.frameLayoutGuide.bottomAnchor).isActive = true
        view.widthAnchor.constraint(greaterThanOrEqualTo: thirdCategoriesView.frameLayoutGuide.widthAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: thirdCategoriesView.contentLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: thirdCategoriesView.contentLayoutGuide.trailingAnchor).isActive = true
        
        return view
    }()
    
    private var views = [ThirdCategoryItemView]()
    private var viewHeight: CGFloat = 0
    
    // MARK: - View
    // MARK: Private
    private lazy var collectionGroupsView: CollectionGroupsSectionView = {
        let collectionGroupsView = CollectionGroupsSectionView()
        
        view.addSubview(collectionGroupsView)
        collectionGroupsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionGroupsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionGroupsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return collectionGroupsView
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionGroupsView.update(groups: CollectionGroupItem.groups)
        setView()
    }
    
    
    // MARK: - Function
    // MARK: Private
    private func setView()  {
        let categories = Array(ThirdCategoryItem.categories.prefix(8))
        
        let result = categories.count.quotientAndRemainder(dividingBy: 2)
        let row = result.quotient + result.remainder
        
        let screenWidth = UIScreen.main.bounds.width
        
        let inset = (screenWidth / 2 + 8)
        let lastIndex = categories.count - 1
        
        viewHeight = CGFloat((row - 1) * 34 + 40)
        
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 1
        
        var leadingInset: CGFloat = 16
        
        categories.enumerated().forEach { (i, category) in
            let view = ThirdCategoryItemView(item: category)
            view.layer.borderColor = UIColor.orange.cgColor
            view.layer.borderWidth = 1
            
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
                
                view.topRange = ThirdCategoryRange(startBound: top, endBound: 16)
                
                view.topConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.topRange.startBound)
                view.topConstraint?.isActive = true
                
                // Leading, Trailing
                let remainder = i % 2
                
                view.leadingRange = ThirdCategoryRange(startBound: remainder == 0 ? 20 : inset, endBound: leadingInset)
                view.trailingRange = ThirdCategoryRange(startBound: remainder == 0 ? -inset : -20, endBound: screenWidth - leadingInset - category.width)
                
                view.leadingConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.leadingRange.startBound)
                view.trailingConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.trailingRange.startBound)
                view.leadingConstraint?.isActive = true
                view.trailingConstraint?.isActive = true
                
                leadingInset += category.width + 16
                
                
                // Bottom
                guard i == lastIndex else { return }
                view.bottomRange = ThirdCategoryRange(startBound: -20, endBound: -14)
                
                view.bottomConstraint = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.bottomRange.startBound)
                view.bottomConstraint?.isActive = true
            }
        }
        
        view.layoutIfNeeded()
    }
    
    private func updateThirdCategoriesView(y: CGFloat) {
        let progress = max(0, min(1, y / viewHeight))
        views.forEach { $0.update(progress: progress) }
        
        view.layoutIfNeeded()
    }
    
    private func updateMagneticEffect(y: CGFloat) {
        guard 0...66 ~= scrollView.contentOffset.y else { return }
        let progress = round(max(0, min(1, scrollView.contentOffset.y / 66)))
        scrollView.setContentOffset(CGPoint(x: 0, y: progress == 0 ? 0 : 66), animated: true)
    }
}

// MARK: - UIScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // collectionGroupsView.handle(y: scrollView.contentOffset.y)
        updateThirdCategoriesView(y: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateMagneticEffect(y: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateMagneticEffect(y: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateMagneticEffect(y: scrollView.contentOffset.y)
    }
}
