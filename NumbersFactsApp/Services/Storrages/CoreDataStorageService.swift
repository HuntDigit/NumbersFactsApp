//
//  CoreDataStorageService.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import CoreData

enum StorageError: Error {
    case fetchingError
    case savingError
}

final class CoreDataStorageService: StorageProtocol {
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: mainStorageContainer)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Can't load persistent container: \(error.localizedDescription)")
            }
        }
    }
 
    func getListOfNumbers() throws -> [NumberDataModel] {
        let fetchRequest = NSFetchRequest<NumberEntity>(entityName: numberEntityName)
        fetchRequest.predicate = .init(value: true)
        return try container.viewContext.fetch(fetchRequest).map { NumberDataModel(from: $0 ) }
    }
    
    func addNumberItem(item: NumberDataModel) {
        let newNumberEntity = NumberEntity(context: container.viewContext)
        newNumberEntity.number = item.number
        newNumberEntity.fact = item.fact
        newNumberEntity.id = item.id
        saveData()
    }
    
    // This is an extra fetch request,
    // but we can remove the item independently
    // without using the list of entities
    
    func removeNumberItem(item: NumberDataModel) throws {
        guard let id = item.id else { throw StorageError.fetchingError }
        
        let fetchRequest = NSFetchRequest<NumberEntity>(entityName: numberEntityName)
        fetchRequest.predicate = .init(format: "id == %@", id)
        let result = try? container.viewContext.fetch(fetchRequest)
        guard let entity = result?.first else {
            throw StorageError.fetchingError
        }
        container.viewContext.delete(entity)
        saveData()
    }
 
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
