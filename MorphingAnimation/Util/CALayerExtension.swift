//
//  CALayerExtension.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/22/25.
//

import UIKit

extension CALayer {
    
    open override func setValue(_ value: Any?, forKey key: String) {
        guard key == "borderColor", let color = value as? UIColor  else {
            return super.setValue(value, forKey: key)
        }
        
        return super.setValue(color.cgColor, forKey: key)
    }
}
