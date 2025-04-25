//
//  AnimationRange.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/24/25.
//

import UIKit

struct AnimationRange {
    var startBound: CGFloat = 0
    var endBound: CGFloat = 0
}

extension AnimationRange {
    
    var length: CGFloat {
        endBound - startBound
    }
    
    private var range: ClosedRange<CGFloat> {
        startBound...max(startBound, endBound)
    }
}

extension AnimationRange {
    
    static func ~= (range: AnimationRange, value: CGFloat) -> Bool {
        if range.startBound <= range.endBound {
            range.startBound...range.endBound ~= value
    
        } else {
            range.endBound...range.startBound ~= value
        }
    }
}
