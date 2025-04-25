//
//  CollectionGroupItemView.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/23/25.
//

import UIKit

@MainActor
final class CollectionGroupItemView: UIControl {
    
    // MARK: - Value
    // MARK: Private
    private var item = CollectionGroupItem()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var imageViewLeadingConstraint: NSLayoutConstraint?
    private var imageViewWidthConstraint: NSLayoutConstraint?
    
    private var labelTopConstraint: NSLayoutConstraint?
    private var labelLeadingConstraint: NSLayoutConstraint?
    private var labelTrailingConstraint: NSLayoutConstraint?
    
    private var highlightViewBottomContraint: NSLayoutConstraint?
    private var highlightViewLeadingContraint: NSLayoutConstraint?
    private var highlightViewTrailingContraint: NSLayoutConstraint?
    
    
    // MARK: - View
    // MARK: Private
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        imageViewLeadingConstraint?.isActive = true
        
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 64)
        imageViewWidthConstraint?.isActive = true
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        labelTopConstraint = label.topAnchor.constraint(equalTo: topAnchor, constant: 88)
        labelTopConstraint?.isActive = true
        
        labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor)
        labelLeadingConstraint?.isActive = true
        
        labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor)
        labelTrailingConstraint?.isActive = true
        
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return label
    }()
    
    private lazy var highlightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 36
        view.layer.zPosition = -10
        view.clipsToBounds = true
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        highlightViewBottomContraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -38)
        highlightViewBottomContraint?.isActive = true
        
        highlightViewLeadingContraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        highlightViewLeadingContraint?.isActive = true
        
        highlightViewTrailingContraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        highlightViewTrailingContraint?.isActive = true
        
        return view
    }()
    
    
    // MARK: - Initializer
    required init(item: CollectionGroupItem) {
        super.init(frame: .zero)
        
        setViews()
        update(item: item)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    
    // MARK: - Function
    // MARK: Public
    func update(item: CollectionGroupItem) {
        self.item = item
        
        imageView.image = UIImage(named: item.title)
        
        label.text = item.title
        label.font = .systemFont(ofSize: 13, weight: item.fontWeight)
        label.textColor = item.textColor
        
        highlightView.layer.borderColor = item.borderColor
        highlightView.layer.borderWidth = item.borderWidth
    }
    
    func update(progress: CGFloat) {
        imageViewWidthConstraint?.constant = 64 - 36 * progress         // 64 ~ 28
        imageView.layer.cornerRadius = 32 - 18 * progress               // 32 ~ 14
        
        imageViewLeadingConstraint?.constant = 8 - 4 * progress         // 8 ~ 4
        
        labelTopConstraint?.constant = 87 - 70 * progress               // 87 ~ 17
        labelLeadingConstraint?.constant = 36 * progress                // 0 ~ 36
        labelTrailingConstraint?.constant = -8 * progress               // 0 ~ -8
        
        label.font = .systemFont(ofSize: 13 + progress, weight: item.fontWeight) // 13 ~ 14
        
        highlightViewBottomContraint?.constant = -37 + 29 * progress    // 37 ~ 8
        highlightViewLeadingContraint?.constant = 4 - 4 * progress      // 4 ~ 0
        highlightViewTrailingContraint?.constant = -4 + 4 * progress    // -4 ~ 0
        
        highlightView.layer.borderWidth = 2 - 1 * progress              // 2 ~ 1
        highlightView.layer.cornerRadius = 36 - 18 * progress           // 36 ~ 18
        
        if !item.isSelected {
            highlightView.layer.borderColor = UIColor(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: progress).cgColor
        }
        
        heightConstraint?.constant = 118 - 66 * progress                // 118 ~ 52
    }
    
    // MARK: Private
    private func setViews() {
        widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: 80)
        widthConstraint?.isActive = true
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 118)
        heightConstraint?.isActive = true
    }
}
