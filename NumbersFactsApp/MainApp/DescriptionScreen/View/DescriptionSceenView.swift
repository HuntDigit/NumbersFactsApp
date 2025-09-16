//
//  DescriptionSceenView.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import SwiftUI

struct DescriptionSceenView: View {
    let dataModel: NumberDataModel
    
    var body: some View {
        VStack(alignment: .center, spacing: defaultVerticalSpacing) {
            Circle()
                .frame(width: 180, height: 180)
                .foregroundColor(.gray.opacity(0.3))
                .overlay {
                    Text("\(dataModel.number)")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                
            VStack(alignment: .leading) {
                Text(descriptionTitle)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                ScrollView {
                    Text(dataModel.fact ?? noDescriptionText)
                        .font(.system(size: 30))
                }
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .navigationTitle(numberInfoTitleText)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        DescriptionSceenView(
            dataModel: NumberDataModel.placeholder
        )
    }
}
