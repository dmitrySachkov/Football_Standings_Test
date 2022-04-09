//
//  AllSeasonsViewModel.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 09.04.2022.
//

import Foundation
import Combine

class AllSeasonsViewModel: ObservableObject {

    private let networkFetcher = NetworkService()
    private var disposables = Set<AnyCancellable>()
    
    @Published var model: SeasonsAvailableModel?
    
    init(urlString: String) {
        networkFetcher.fetchAveliableSeasons(urlString: urlString)
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                self.model = value
             })
            .store(in: &disposables)
    }
}
