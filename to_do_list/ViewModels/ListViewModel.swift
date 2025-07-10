//
//  ListViewModel.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 10/07/2025.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemKeys: String = "items_key"
    
    init() {
        getItems()
    }
    
    func getItems(){
//        let newItems = [
//            ItemModel(title: "This is the first title", isCompleted: false),
//            ItemModel(title: "This is the second title", isCompleted: false),
//            ItemModel(title: "This is the third title", isCompleted: true)
//        ]
//        items.append(contentsOf: newItems)
        guard
            let data = UserDefaults.standard.data(forKey: itemKeys),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {
            return
        }
        
        self.items = savedItems
    }
    
    func addItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
    }
    
    func deleteItems(at offsets: IndexSet, from filteredItems: [ItemModel]) {
        // Map filtered list indexes to actual indexes in items array
        let idsToDelete = offsets.map { filteredItems[$0].id }
        
        // Remove items matching those ids from the main items array
        items.removeAll { idsToDelete.contains($0.id) }
    }

    func deleteAllItems() {
        items.removeAll()
    }

    func moveItems(from source: IndexSet, to destination: Int, in filteredItems: [ItemModel]) {
        //finishedItems are Task 1, Task 2, and Task 4.
        //We move the item at index 1 in finishedItems (Task 2) to index 0 in finishedItems.
        //The method removes Task 2 from the main items and inserts it before Task 1 in the main items.
        //The output shows the updated order.
        
        // Get the items to move from the filtered list
        //We move the item at index 1 in finishedItems (Task 2) to index 0 in finishedItems.
        let movingItems = source.map { filteredItems[$0] }
        //let movingItems = source.map { filteredItems[1] } // movingItems = Task2

        // Remove these items from the main list
        //The method removes Task 2 from the main items ->
        items.removeAll { item in movingItems.contains(where: { $0.id == item.id }) }
        //items.removeAll { item in movingItems.contains(where: { Task2.id == item.id }) }

        // Calculate the insertion index in the main list
        // Find the item in the filtered list at destination index (if destination is not at end)
        //->and inserts it before Task 1 in the main items.
        let insertIndex: Int
        if destination >= filteredItems.count { //desitnation == 0, filteredItems.count == (eg:3)
            insertIndex = items.count //destination is greater than .count so go to else
        } else {
            let destinationItem = filteredItems[destination] //destinationItem = Task1
            insertIndex = items.firstIndex(where: { $0.id == destinationItem.id }) ?? items.count
            //loop and find the first macth with firstIndex ->
            //looping's item is == Task1.id -> match -> get insertIndex to insert
        }

        // Insert moving items at calculated index
        items.insert(contentsOf: movingItems, at: insertIndex)
    }

    
    
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodeData, forKey: itemKeys)
        }
    }
}
