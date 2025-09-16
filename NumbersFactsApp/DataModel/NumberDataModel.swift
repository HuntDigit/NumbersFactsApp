//
//  NumberDataModel.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

/*   Info!
 *   We are ignoring the next values from the API because we don't use them.
 *   [ date, type, found ]
 */
import Foundation

struct NumberDataModel: Codable, Hashable, Identifiable {
    
    var id: String?
    let number: Int64
    let fact: String?
    
    init(from entity: NumberEntity) {
        self.number = entity.number
        self.fact = entity.fact
        self.id = entity.id
    }
    
    init(number: Int64, fact: String) {
        self.number = number
        self.fact = fact
        self.id = UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case number, id
        case fact = "text"
    }
    
    
    var numberText: String {
        "\(number)"
    }
    
    var factText: String {
        fact ?? noFactsText
    }
}

extension NumberDataModel {
    static let placeholder: NumberDataModel = .init(number: 1234, fact: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.")
}
