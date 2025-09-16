//
//  UserDefaultsStorageService.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

import SwiftUI

class UserDefaultsStorageService: StorageProtocol {
    
    private var listOfNumbers: [NumberDataModel] = []
    
    func getListOfNumbers() throws -> [NumberDataModel] {
        if let data = UserDefaults.standard.data(forKey: mainStorageKey) {
            listOfNumbers = try decodeListOfNumbers(from: data)
        } else {
            throw StorageError.fetchingError
        }
        return listOfNumbers
    }
    
    func addNumberItem(item: NumberDataModel) {
        listOfNumbers.append(item)
        saveData()
    }
    
    func removeNumberItem(item: NumberDataModel) throws {
        guard let index = listOfNumbers.firstIndex(of: item) else {
            throw StorageError.fetchingError
        }
        listOfNumbers.remove(at: index)
        saveData()
    }
    
    func saveData() {
        do {
            let encoded = try encodeListOfNumbers()
            UserDefaults.standard.set(encoded, forKey: mainStorageKey)
        } catch {
            fatalError("Cannot encode and save data")
        }
    }
}

extension UserDefaultsStorageService {
    private func encodeListOfNumbers() throws -> Data {
        return try JSONEncoder().encode(listOfNumbers)
    }
    
    private func decodeListOfNumbers(from data: Data) throws -> [NumberDataModel] {
        return try JSONDecoder().decode([NumberDataModel].self, from: data)
    }
}
