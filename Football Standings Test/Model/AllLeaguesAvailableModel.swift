//
//  AllLeaguesAvailableModel.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import Foundation

// MARK: - AllLeaguesAvailableModel
struct AllLeaguesAvailableModel: Codable {
    let status: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, name, slug, abbr: String
    let logos: Logos
}

// MARK: - Logos
struct Logos: Codable {
    let light: String
    let dark: String
}
