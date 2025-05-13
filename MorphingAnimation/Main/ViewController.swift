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
    
    // MARK: - View
    // MARK: Private
    private lazy var collectionGroupSectionView: CollectionGroupsSectionView = {
        let collectionGroupsView = CollectionGroupsSectionView()
        view.addSubview(collectionGroupsView)
        
        collectionGroupsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionGroupsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionGroupsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return collectionGroupsView
    }()
    
    private lazy var thirdCategorySectionView: ThirdCategorySectionView = {
        let sectionView = ThirdCategorySectionView()
        view.addSubview(sectionView)
        
        sectionView.topAnchor.constraint(equalTo: collectionGroupSectionView.bottomAnchor).isActive = true
        sectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return sectionView
    }()
     
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionGroupSectionView.update(items: CollectionGroupItem.items)
        thirdCategorySectionView.update(items: ThirdCategoryItem.items)
        
        collectionGroupSectionView.animationRange = AnimationRange(startBound: 160, endBound: 226)
        thirdCategorySectionView.animationRange = AnimationRange(startBound: 0, endBound: 160)
    }
    
    
    // MARK: - Function
    // MARK: Private
    private func updateMagneticEffect(y: CGFloat) {
        if collectionGroupSectionView.animationRange ~= scrollView.contentOffset.y {
            let length = collectionGroupSectionView.animationRange.length
            let progress = round(max(0, min(1, (scrollView.contentOffset.y - collectionGroupSectionView.animationRange.startBound) / length)))
            
            let offset = CGPoint(x: 0, y: progress == 0 ? collectionGroupSectionView.animationRange.startBound : collectionGroupSectionView.animationRange.endBound)
            scrollView.setContentOffset(offset, animated: true)
            
        } else if thirdCategorySectionView.animationRange ~= scrollView.contentOffset.y {
            let length = thirdCategorySectionView.animationRange.length
            let progress = round(max(0, min(1, (scrollView.contentOffset.y - thirdCategorySectionView.animationRange.startBound) / length)))
            
            let offset = CGPoint(x: 0, y: progress == 0 ? thirdCategorySectionView.animationRange.startBound : thirdCategorySectionView.animationRange.endBound)
            scrollView.setContentOffset(offset, animated: true)
        }
    }
}

// MARK: - UIScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionGroupSectionView.handle(y: scrollView.contentOffset.y)
        thirdCategorySectionView.handle(y: scrollView.contentOffset.y)
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
