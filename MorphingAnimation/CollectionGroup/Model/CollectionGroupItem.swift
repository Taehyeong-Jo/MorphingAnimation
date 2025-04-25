//
//  CollectionGroupItem.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/22/25.
//

import UIKit

struct CollectionGroupItem {
    var title = ""
    var imageURL: URL?
    var isSelected = false
}

extension CollectionGroupItem {
    
    var textColor: UIColor {
        isSelected ? #colorLiteral(red: 0.5512642264, green: 0.3013183177, blue: 0.7702756524, alpha: 1) : #colorLiteral(red: 0.2980392277, green: 0.2980392277, blue: 0.2980392277, alpha: 1)
    }
    
    var fontWeight: UIFont.Weight {
        isSelected ? .bold : .regular
    }
    
    var borderColor: CGColor {
        (isSelected ? #colorLiteral(red: 0.5512642264, green: 0.3013183177, blue: 0.7702756524, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)).cgColor
    }
    
    var borderWidth: CGFloat {
        isSelected ? 2 : 1
    }
}

extension CollectionGroupItem {
    
    static var items: [CollectionGroupItem] {
        [CollectionGroupItem(title: "TOP500",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/10134/vLcoMNMMJuN3zUDTqzvTkYkGekE4f4dzX0SWJ2Cs.png"),
                  isSelected: true),
         
         CollectionGroupItem(title: "간편식사",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E5VxSGbzeu8GEYdaTtvquaPAsc4mPrjmLFFteOUAB.png")),
         CollectionGroupItem(title: "신선코너",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/10190/Pa0oTcj3ZYQHmZJtLEOxi5HS5Gl7GfALYghXolKA.png")),
         CollectionGroupItem(title: "컬리정육점",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/10189/emK14wmlRqEtq5dm8M6TVURMET4BzqA4EK6EsOua.png")),
         CollectionGroupItem(title: "컬리에만있는",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/11433/AtTVde9pLvRnj7pxIedwIR62AZqYdGHTz9EkTYmE.png")),
         CollectionGroupItem(title: "인기급상승",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/11460/7z2WC4M5ZBtboOY9roG2mkt1AYia1i93krcym1yx.png")),
         CollectionGroupItem(title: "생활필수품",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/10191/MQhoU0200f9n607mRvnzodZ10eSZQJSYIr6bN1oL.png")),
         CollectionGroupItem(title: "직원추천상품",
                  imageURL: URL(string: "https://collection-image.kurly.com/hdims/resize/%5E%3E192x%3E192/cropcenter/192x192/quality/85/src/product-collections/12342/3P7djQSaPPB9tuqrpC9QMrt8NBBAE5g0rUrOE5eq.png"))]
    }
}
