//
//  ListRowView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI


struct ListRowView: View {
    
    var item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .gray)

            Text(item.title)
            Spacer()
        }
    }
}
