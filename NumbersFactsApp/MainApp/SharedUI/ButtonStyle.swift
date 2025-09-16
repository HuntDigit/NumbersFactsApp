//
//  ButtonStyle.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

import SwiftUI

struct RequestButtonStyleRounded: ButtonStyle {
    
    let isDisabled: Bool
    
    init(_ isDisabled: Bool = false) {
        self.isDisabled = isDisabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .disabled(isDisabled)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(4)
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
