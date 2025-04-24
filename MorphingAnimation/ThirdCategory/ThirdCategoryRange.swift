//
//  ThirdCategoryRange.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/24/25.
//

import UIKit

struct ThirdCategoryRange {
    var startBound: CGFloat = 0
    var endBound: CGFloat = 0
}

extension ThirdCategoryRange {
    
    var length: CGFloat {
        endBound - startBound
    }
}
