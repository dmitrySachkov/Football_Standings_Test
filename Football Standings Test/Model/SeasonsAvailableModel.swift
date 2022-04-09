//
//  SeasonsAvailableModel.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import Foundation

// MARK: - SeasonsAvailableModel
struct SeasonsAvailableModel: Codable {
    let status: Bool
    let data: Data
}

// MARK: - DataClass
struct Data: Codable {
    let desc: String
    let seasons: [Season]
}

// MARK: - Season
struct Season: Codable {
    let year: Int
    let startDate, endDate, displayName: String
    let types: [TypeElement]
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let id, name, abbreviation, startDate: String
    let endDate: String
    let hasStandings: Bool
}
