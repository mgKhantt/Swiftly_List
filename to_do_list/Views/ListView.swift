//
//  ListView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var finishedItems: [ItemModel] {
        listViewModel.items.filter{$0.isCompleted}
    }
    
    var unFinishedItems: [ItemModel] {
        listViewModel.items.filter{!$0.isCompleted}
    }
    
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
                        if !finishedItems.isEmpty {
                            Section("Finish") {
                                ForEach(listViewModel.items.filter{$0.isCompleted}) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                }
                                .onMove { indices, newOffset in
                                    listViewModel.moveItems(from: indices, to: newOffset, in: finishedItems)
                                }
                                .onDelete { indexSet in
                                    listViewModel.deleteItems(at: indexSet, from: finishedItems)
                                }
                            }
                        }
                        
                        if !unFinishedItems.isEmpty {
                            Section("UnFinish") {
                                ForEach(listViewModel.items.filter{!$0.isCompleted}) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                }
                                .onMove { indices, newOffset in
                                    listViewModel.moveItems(from: indices, to: newOffset, in: unFinishedItems)
                                }
                                .onDelete { indexSet in
                                    listViewModel.deleteItems(at: indexSet, from: unFinishedItems)
                                }
                            }
                        }
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        listViewModel.deleteAllItems()
                    } label: {
                        Text("Delete All")
                            .foregroundStyle(.red)
                    }
                    
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}
