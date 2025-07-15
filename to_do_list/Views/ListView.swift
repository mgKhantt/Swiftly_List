import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var showAlert: Bool = false
    
    @State private var itemToEdit: ItemModel?
    @State private var newTitle: String = ""
    @State private var showEditSheet: Bool = false
    @State private var newItemType: ItemType = .personal
    
    @Binding var showAddSheet: Bool
    
    @State var showEmptyAlert: Bool = false
    
    @State var textFieldText: String = ""
    
    
    var groupedItemsByType: [ItemType: [ItemModel]] {
        Dictionary(grouping: listViewModel.items.filter {!$0.isCompleted}){ $0.itemType }
    }
    
    @State var selectedOption: ItemType = .personal
    
    
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
                                                newItemType = item.itemType
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
                            ForEach(ItemType.allCases) { type in
                                if let items = groupedItemsByType[type], !items.isEmpty {
                                    Section(header: HStack {
                                        Image(systemName: type.icon)
                                            .foregroundColor(type.iconColor)
                                        Text(type.rawValue)
                                    }) {
                                        ForEach(items) { item in
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
                                                        newItemType = item.itemType
                                                        showEditSheet = true
                                                    } label: {
                                                        Text("Edit")
                                                    }
                                                    .tint(.indigo)
                                                }
                                        }
                                        .onMove { indices, newOffset in
                                            listViewModel.moveItems(from: indices, to: newOffset, in: items)
                                        }
                                        .onDelete { indexSet in
                                            listViewModel.deleteItems(at: indexSet, from: items)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.insetGrouped)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }
                Spacer(minLength: 38)
            }
            .frame(maxWidth: 600)
        
            .navigationTitle("Swiftly List")
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
            .sheet(isPresented: $showAddSheet) {
                NavigationView {
                    Form {
                        TextField("Enter the task", text: $textFieldText)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                        Picker("Item Type", selection: $selectedOption) {
                            ForEach(ItemType.allCases) { type in
                                HStack {
                                    Image(systemName: type.icon)
                                    Text("\(type.rawValue)")
                                }
                                .tint(type.iconColor)
                                .tag(type)
                            }
                        }
                    }
                    .navigationTitle("Add Task")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showAddSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                print("Save button press")
                                print("Text field: \(textFieldText)")
                                if textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    showEmptyAlert = true
                                    return
                                }
                                listViewModel.addItem(title: textFieldText, itemType: selectedOption)
                                showAddSheet = false
                                textFieldText = ""
                                hideKeyboard()
                            }
                        }
                    }
                    .alert("Please fill the text field", isPresented: $showEmptyAlert) {
                        Button("OK", role: .cancel) {}
                    }
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            
            .sheet(isPresented: $showEditSheet) {
                NavigationView {
                    Form {
                        TextField("Edit Title", text: $newTitle)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                        Picker("Item Type", selection: $newItemType) {
                            ForEach(ItemType.allCases) { type in
                                HStack {
                                    Image(systemName: type.icon)
                                    Text("\(type.rawValue)")
                                }
                                .tint(type.iconColor)
                                .tag(type)
                            }
                        }
                    }
                    .navigationTitle("Edit Item")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showEditSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            withAnimation(.spring()) {
                                Button("Save") {
                                    if newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        showEmptyAlert = true
                                        return
                                    }
                                    if let item = itemToEdit {
                                        listViewModel.editItem(item: item, newTitle: newTitle, newType: newItemType)
                                    }
                                    showEditSheet = false
                                }
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
