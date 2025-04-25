//
//  ThirdCategoryItem.swift
//  MorphingAnimation
//
//  Created by Den Jo on 4/23/25.
//

import UIKit

struct ThirdCategoryItem {
    var code = ""
    var name = ""
    var isSelected = false
}

extension ThirdCategoryItem {
    
    var width: CGFloat {
        ceil(name.size(withAttributes: [.font : UIFont.systemFont(ofSize: 14)]).width)
    }
}

extension ThirdCategoryItem {
    
    var textColor: UIColor {
        isSelected ? #colorLiteral(red: 0.5512642264, green: 0.3013183177, blue: 0.7702756524, alpha: 1) : #colorLiteral(red: 0.2980392277, green: 0.2980392277, blue: 0.2980392277, alpha: 1)
    }
    
    var font: UIFont {
        .systemFont(ofSize: 14, weight: isSelected ? .semibold : .regular)
    }
}

extension ThirdCategoryItem: RawRepresentable {
    
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else { return nil }
        do { self = try JSONDecoder().decode(Self.self, from: data) } catch { return nil }
    }
    
    var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}

extension ThirdCategoryItem: CustomStringConvertible {
   
    var description: String {
        "\(code) | \(name)"
    }
}

extension ThirdCategoryItem: CustomDebugStringConvertible {
    
    var debugDescription: String {
        description
    }
}

extension ThirdCategoryItem: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension ThirdCategoryItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ThirdCategoryItem: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension ThirdCategoryItem: Codable {

    private enum Key: String, CodingKey {
        case code
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(code, forKey: .code)
        try container.encode(name, forKey: .name)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
    }
}

#if DEBUG
extension ThirdCategoryItem {
    
    static var items: [ThirdCategoryItem] {
        [ThirdCategoryItem(code: "1", name: "전체보기", isSelected: true),
         ThirdCategoryItem(code: "2", name: "Kurly's"), ThirdCategoryItem(code: "3", name: "PPUL"), ThirdCategoryItem(code: "4", name: "일상미소"),
         ThirdCategoryItem(code: "5", name: "KF365"), ThirdCategoryItem(code: "6", name: "KS365"), ThirdCategoryItem(code: "7", name: "Better Me"), ThirdCategoryItem(code: "8", name: "동물복지")]
    }
}
#endif
