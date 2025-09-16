//
//  NumberTextView.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 16.09.2025.
//

import SwiftUI

struct NumberTextView: View {
    
    @Binding var number: String
    @FocusState var isFocused
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.white)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .frame(width: 22, height: 22)
                        .padding(14)
                    ZStack(alignment: .leading) {
                        if !isFocused && number.isEmpty {
                            Text(placeholderText)
                                .font(.system(size: 14))
                                .foregroundStyle(.gray.mix(with: .white, by: 0.1))
                                .padding(.vertical, 14)
                        }
                        TextField("", text: $number)
                            .onChange(of: number) { _ , newValue in
                                number = newValue.filter { $0.isNumber }
                            }
                            .font(.system(size: 18))
                            .focused($isFocused)
                            .foregroundStyle(.gray)
                            .textFieldStyle(.plain)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 14)
                    }
                }
            }
            .frame(height: 64)
            
            Button {
                number = ""
                isFocused = false
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(.white)
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .frame(width: 22, height: 22)
                        .padding(14)

                }
            }
            .frame(width: 64, height: 64)
        }
    }
}

#Preview {
    @Previewable @State var number: String = ""
    NumberTextView(number: $number)
        .padding(16)
        .background(Color.gray)
}
