//
//  MainScreenViewModel.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import CoreData

enum CommonError: String, Error {
    case invalidNumber
    //...
    
    var localizedDescription: String {
        switch self {
        case .invalidNumber:
            return invalidNumberErrorText
        }
    }
}

@MainActor
class MainScreenViewModel: ObservableObject {
    private var storageService: StorageProtocol
    private var networkService: NetworkService

    @Published var recentSevedItems: [NumberDataModel] = []
    @Published var errorMessage: String = ""

    init (storageService: StorageProtocol, networkService: NetworkService) {
        self.storageService = storageService
        self.networkService = networkService
    }
    
    func taskRequestNumber(_ number: String) {
        guard let number = Int64(number) else {
            errorMessage = CommonError.invalidNumber.localizedDescription.capitalized
            return
        }
        
        Task {
            do {
                try await requestNumberFact(request: .number(number))
            } catch let error {
                errorMessage = error.localizedDescription.capitalized
            }
        }
    }
    
    func taskRequestRandom() {
        Task {
            do {
                try await requestNumberFact(request: .random)
            } catch let error {
                errorMessage = error.localizedDescription.capitalized
            }
        }
    }
    
    func requestNumberFact(request: RequestNumber) async throws  {
        let model = try await networkService.fetchNumberMath(request: request)
        storageService.addNumberItem(item: model)
        loadRecentSavedItems()
    }
    
    func deleteItem(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let item = recentSevedItems[index]
        do {
            try storageService.removeNumberItem(item: item)
            updateList()
        } catch {
            errorMessage = error.localizedDescription.capitalized
        }
    }
    
    func loadRecentSavedItems() {
        do {
            recentSevedItems = try storageService.getListOfNumbers()
        } catch {
            print("Error fetching recent saved items: \(error.localizedDescription)")
        }
    }
    
    func updateList() {
        loadRecentSavedItems()
    }
}
