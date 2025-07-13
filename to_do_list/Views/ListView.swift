import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var showAlert: Bool = false
    @State private var itemToEdit: ItemModel?
    @State private var newTitle: String = ""
    @State private var showEditSheet: Bool = false
    
    @State var showEmptyAlert: Bool = false
    
    
    
    var finishedItems: [ItemModel] {
        listViewModel.items.filter { $0.isCompleted }
    }
    
    var unFinishedItems: [ItemModel] {
        listViewModel.items.filter { !$0.isCompleted }
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                AddView()
                
                if listViewModel.items.isEmpty {
                    NoItemsView()
                        .padding()
                } else {
                    List {
                        if !finishedItems.isEmpty {
                            Section("Finished") {
                                ForEach(finishedItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                itemToEdit = item
                                                newTitle = item.title
                                                showEditSheet = true
                                            } label: {
                                                Text("Edit")
                                            }
                                            .tint(.indigo)
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
                            Section("Unfinished") {
                                ForEach(unFinishedItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                itemToEdit = item
                                                newTitle = item.title
                                                showEditSheet = true
                                            } label: {
                                                Text("Edit")
                                            }
                                            .tint(.indigo)
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
                    .listStyle(.insetGrouped)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .frame(maxWidth: 600)
            .navigationTitle("To Do List 📝")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Text("Delete All")
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented: $showEditSheet) {
                NavigationView {
                    Form {
                        TextField("Edit Title", text: $newTitle)
                    }
                    .navigationTitle("Edit Item")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showEditSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                if newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    showEmptyAlert = true
                                    return
                                }
                                if let item = itemToEdit {
                                    listViewModel.editItem(item: item, newTitle: newTitle)
                                }
                                showEditSheet = false
                            }
                        }
                        
                    }
                    .alert("Please fill the text field", isPresented: $showEmptyAlert) {
                        Button("OK", role: .cancel) {}
                    }
                }
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
            }
            .alert("Do you want to delete all items?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    listViewModel.deleteAllItems()
                }
                Button("Cancel", role: .cancel) {}
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        hideKeyboard()
                    }
            )
        }
    }
}
