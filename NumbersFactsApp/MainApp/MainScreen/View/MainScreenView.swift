//
//  MainScreenView.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject private var vm: MainScreenViewModel
    @State private var number: String = ""
    
    init(storageService: StorageProtocol,
         networkService: NetworkService) {
        self.vm = .init(storageService: storageService,
                        networkService: networkService)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: defaultVerticalSpacing) {
                    topSector
                    bottomSector
                }
            }
            .navigationDestination(for: NumberDataModel.self) { item in
                DescriptionSceenView(dataModel: item)
            }
            .navigationTitle(interestingFactsTitleText)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(vm.errorMessage, isPresented: isShowError) {
            Button(okText) { }
        }
        .onAppear() {
            vm.loadRecentSavedItems()
        }
    }
    
    private var topSector: some View {
        VStack(spacing: defaultVerticalSpacing) {
            NumberTextView(number: $number)
                .padding(.horizontal, 16)

            Button { vm.taskRequestNumber(number) } label: {
                Text(requestFactText)
            }
            .buttonStyle(RequestButtonStyleRounded(number.isEmpty))
            .padding(.horizontal, 16)

            Button { vm.taskRequestRandom() } label: {
                Text(randomNumberText)
            }
            .buttonStyle(RequestButtonStyleRounded())
            .padding(.horizontal, 16)
        }
    }
    
    private var bottomSector: some View {
        VStack(spacing: defaultVerticalSpacing) {
            List {
                Section {
                    ForEach(vm.recentSevedItems) { item in
                        NavigationLink(value: item) {
                            HStack(alignment: .center) {
                                Text(item.numberText)
                                    .frame(width: 50)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                Text(item.factText)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteItem)
                } header: {
                    recentFactLabel
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .listStyle(PlainListStyle())
        }
    }
    
    private var recentFactLabel: some View {
        if vm.recentSevedItems.isEmpty {
            Text(noRecentFactsText)
                .font(.headline)
        } else {
            Text(recentFactsText)
                .font(.headline)
        }
    }
}

extension MainScreenView {
    var isShowError: Binding<Bool> {
        Binding(get: { !vm.errorMessage.isEmpty },
                set: { $0 == false ? vm.errorMessage = "" : () })
        
    }
}

#Preview {
    MainScreenView(storageService: CoreDataStorageService(),
                   networkService: NetworkService())
}
