//
//  MainApp.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import SwiftUI

@main
struct MainApp: App {
    
    // Here is we can choise which type storage we gonna use in our app
    // Available 2 types .coreData and .userDefaults
    private let storageService = StorageService.makeStorage(type: .coreData)
    private let networkService = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            MainScreenView(storageService: storageService,
                           networkService: networkService)
        }
    }
}
