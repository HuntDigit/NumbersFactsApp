//
//  CoreDataHelper.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import CoreData

extension String {
    static func entityName<T: AnyObject>(_ entity: T.Type) -> String {
        NSStringFromClass(entity)
    }
}

extension NumberDataModel {
    func toEntity(_ context: NSManagedObjectContext) -> NumberEntity {
        let entity = NumberEntity(context: context)
        entity.number = number
        entity.fact = fact
        entity.id = id
        return entity
    }
}
