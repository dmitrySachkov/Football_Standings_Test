//
//  LeagueStandingViewModel.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import Foundation

import Foundation
import Combine

class LeagueStandingViewModel: ObservableObject {

    private let networkFetcher = NetworkService()
    private var disposables = Set<AnyCancellable>()
    
    @Published var model: StandingsModel?
    
    init(urlString: String) {
        print(urlString)
        networkFetcher.fetchLeagueStanding(urlString: urlString)
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                self.model = value
                print(value)
             })
            .store(in: &disposables)
    }
}
