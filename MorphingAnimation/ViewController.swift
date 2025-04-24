//
//  ViewController.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/22/25.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Value
    // MARK: Private
    private var thirdPartyCategoryViewHeightContraint: NSLayoutConstraint?
    
    
    // MARK: - View
    // MARK: Private
    private lazy var collectionGroupsView: CollectionGroupsView = {
        let collectionGroupsView = CollectionGroupsView()
        
        view.addSubview(collectionGroupsView)
        collectionGroupsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionGroupsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionGroupsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return collectionGroupsView
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionGroupsView.update(groups: CollectionGroup.groups)
    }
    
    
    // MARK: - Function
    // MARK: Private
   
    
    private func updateThirdCategoriesView(y: CGFloat) {
        // 0 ~ 112
        let progress = max(0, min(1, y / 112))

        
//        thirdPartyCategoryViewHeightContraint?.constant = 160 - 112 * progress
    }
}

// MARK: - UIScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionGroupsView.handle(y: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard 0...66 ~= scrollView.contentOffset.y else { return }
        let progress = round(max(0, min(1, scrollView.contentOffset.y / 66)))
        scrollView.setContentOffset(CGPoint(x: 0, y: progress == 0 ? 0 : 66), animated: true)
    }
}
