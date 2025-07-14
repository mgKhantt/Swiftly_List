//
//  ItemModel.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 10/07/2025.
//

import Foundation
import SwiftUICore

struct ItemModel: Identifiable, Codable {
    let id: String
    var title: String
    let isCompleted: Bool
    var itemType: ItemType

    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, itemType: ItemType) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.itemType = itemType
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, itemType: itemType)
    }
}

enum ItemType: String, Codable, CaseIterable, Identifiable {
    case personal = "Personal"
    case work = "Work"
    case important = "Important"
    case others = "Others"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
            case .personal: return "person.circle.fill"
            case .work: return "briefcase.fill"
            case .important: return "exclamationmark.triangle.fill"
            case .others: return "ellipsis.circle"
        }
    }
    
    var iconColor: Color {
        switch self {
            case .personal: return .blue
            case .work: return .orange
            case .important: return .red
            case .others: return .gray
        }
    }
}
