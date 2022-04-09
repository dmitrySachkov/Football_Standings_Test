//
//  StandingsModel.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import Foundation

// MARK: - StandingsModel
struct StandingsModel: Codable {
    let status: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let name, abbreviation, seasonDisplay: String
    let season: Int
    let standings: [Standing]
}

// MARK: - Standing
struct Standing: Codable {
    let team: Team
    let note: Note?
    let stats: [Stat]
}

// MARK: - Note
struct Note: Codable {
    let color, noteDescription: String
    let rank: Int

    enum CodingKeys: String, CodingKey {
        case color
        case noteDescription = "description"
        case rank
    }
}

// MARK: - Stat
struct Stat: Codable {
    let name: Name
    let displayName: Description
    let shortDisplayName: ShortDisplayName
    let statDescription: Description
    let abbreviation: Abbreviation
    let type: TypeEnum
    let value: Int?
    let displayValue: String
    let id, summary: String?

    enum CodingKeys: String, CodingKey {
        case name, displayName, shortDisplayName
        case statDescription = "description"
        case abbreviation, type, value, displayValue, id, summary
    }
}

enum Abbreviation: String, Codable {
    case a = "A"
    case d = "D"
    case f = "F"
    case gd = "GD"
    case gp = "GP"
    case l = "L"
    case p = "P"
    case pd = "PD"
    case ppg = "PPG"
    case r = "R"
    case rc = "RC"
    case total = "Total"
    case w = "W"
}

enum Description: String, Codable {
    case draws = "Draws"
    case gamesPlayed = "Games Played"
    case goalDifference = "Goal Difference"
    case goalsAgainst = "Goals Against"
    case goalsFor = "Goals For"
    case losses = "Losses"
    case overall = "Overall"
    case overallRecord = "Overall Record"
    case pointDeductions = "Point Deductions"
    case points = "Points"
    case pointsPerGame = "Points Per Game"
    case rank = "Rank"
    case rankChange = "Rank Change"
    case wins = "Wins"
}

enum Name: String, Codable {
    case allSplits = "All Splits"
    case deductions = "deductions"
    case gamesPlayed = "gamesPlayed"
    case losses = "losses"
    case pointDifferential = "pointDifferential"
    case points = "points"
    case pointsAgainst = "pointsAgainst"
    case pointsFor = "pointsFor"
    case ppg = "ppg"
    case rank = "rank"
    case rankChange = "rankChange"
    case ties = "ties"
    case wins = "wins"
}

enum ShortDisplayName: String, Codable {
    case a = "A"
    case d = "D"
    case deductions = "Deductions"
    case f = "F"
    case gd = "GD"
    case gp = "GP"
    case l = "L"
    case over = "OVER"
    case p = "P"
    case ppg = "PPG"
    case rank = "Rank"
    case rankChange = "Rank Change"
    case w = "W"
}

enum TypeEnum: String, Codable {
    case deductions = "deductions"
    case gamesplayed = "gamesplayed"
    case losses = "losses"
    case pointdifferential = "pointdifferential"
    case points = "points"
    case pointsagainst = "pointsagainst"
    case pointsfor = "pointsfor"
    case ppg = "ppg"
    case rank = "rank"
    case rankchange = "rankchange"
    case ties = "ties"
    case total = "total"
    case wins = "wins"
}

// MARK: - Team
struct Team: Codable {
    let id, uid, location, name: String
    let abbreviation, displayName, shortDisplayName: String
    let isActive: Bool
    let logos: [Logo]
}

// MARK: - Logo
struct Logo: Codable {
    let href: String
    let width, height: Int
    let alt: String
    let rel: [Rel]
    let lastUpdated: String
}

//enum LastUpdated: String, Codable {
//    case the20190508T1607Z = "2019-05-08T16:07Z"
//}

enum Rel: String, Codable {
    case full = "full"
    case relDefault = "default"
}
