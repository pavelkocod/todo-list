//
//  BuketListViewModel.swift
//  BucketListSwiftUI
//
//  Created by Александр Павелко on 30.09.2023.
//

import Foundation

class BuketListViewModel: ObservableObject {
    @Published var listItem: [BucketListItemModel] = [BucketListItemModel(name: "See the ocean"), BucketListItemModel(name: "Buy a house"), BucketListItemModel(name: "Visit Japan")]
    
    // MARK - CRUD functions
    
    func createItem(name: String) {
        let newItem = BucketListItemModel(name: name)
        listItem.append(newItem)
        saveToPersistenceStore()
    }
    
    func toggleIsCompleted(item: BucketListItemModel) {
        guard let index = listItem.firstIndex(of: item) else { return }
        listItem[index].isComplited.toggle()
        saveToPersistenceStore()
    }
    
    func deleteItem(index: IndexSet) {
        listItem.remove(atOffsets: index)
        saveToPersistenceStore()
    }
     
    // MARK: Persistance Store
    
    func createPersistanceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("BucketList.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(listItem)
            try data.write(to: createPersistanceStore())
        } catch {
            print("Error info saving")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistanceStore())
            listItem = try JSONDecoder().decode([BucketListItemModel].self, from: data)
        } catch {
            print("Error info saving")
        }
    }
}
