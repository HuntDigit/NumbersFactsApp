//
//  StorageProtocol.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

protocol StorageProtocol {
    func getListOfNumbers() throws -> [NumberDataModel]
    func addNumberItem(item: NumberDataModel)
    func removeNumberItem(item: NumberDataModel) throws
    func saveData()
}
