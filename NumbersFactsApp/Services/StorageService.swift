//
//  StorageService.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

import Foundation

enum StorageType {
    case coreData
    case userDefaults
}

final class StorageService {
    static func makeStorage(type: StorageType) -> StorageProtocol {
        switch type {
        case .coreData:
            return CoreDataStorageService()
        case .userDefaults:
            return UserDefaultsStorageService()
        }
    }
}
