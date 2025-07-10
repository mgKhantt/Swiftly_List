//
//  ListView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI

struct ListView: View {

    @EnvironmentObject var listViewModel: ListViewModel

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea() // Makes the background cover the whole screen

            VStack {
                AddView()
                if listViewModel.items.isEmpty {
                    NoItemsView()
                } else {
                    List {
                        ForEach(listViewModel.items) { item in
                            ListRowView(item: item)
                                .onTapGesture {
                                    withAnimation(.linear) {
                                        listViewModel.updateItem(item: item)
                                    }
                                }
                        }
                        .onMove(perform: listViewModel.moveItem)
                        .onDelete(perform: listViewModel.deleteItem)
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.insetGrouped) // Gives a modern grouped style
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: 600)
            .navigationTitle("To Do List 📝")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
