//
//  MainApp.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import SwiftUI

@main
struct MainApp: App {
    
    // Here we can choose which type of storage to use in our app.
    // Two options are available: .coreData and .userDefaults
    private let storageService = StorageService.makeStorage(type: .coreData)
    private let networkService = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            MainScreenView(storageService: storageService,
                           networkService: networkService)
        }
    }
}
