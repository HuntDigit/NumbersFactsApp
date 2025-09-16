//
//  Constants.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import Foundation

// MARK: List of Storage Containers
/*
 If we are going to use more storages, it would be good to keep it constant.
 */
let mainStorageContainer: String = "MainStorageContainer"
let mainStorageKey: String = "MainStorageKey"

// MARK: - List of Entity Names

let numberEntityName: String =  .entityName(NumberEntity.self)

// MARK: - Padding

let defaultVerticalSpacing: CGFloat = 16

// MARK: - Text

let interestingFactsTitleText: String = "Interesting facts about numbers!"
let placeholderText: String = "Write a number to get a fun fact"
let noRecentFactsText: String = "No recent facts yet..."
let recentFactsText: String = "Recent Facts"
let noFactsText: String = "No fact available"

let descriptionTitle: String = "Description"
let noDescriptionText: String = "No description"
let numberInfoTitleText: String = "Number Info"

let requestFactText: String = "Get fact"
let randomNumberText: String = "Get fact about random number"
let okText: String = "OK"

// Errors
let invalidNumberErrorText: String = "Please enter valid number"
let noInternetConnectionErrorText: String = "No internet connection"
// ... more
