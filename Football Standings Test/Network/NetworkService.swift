//
//  Network.swift
//  Football Standings Test
//
//  Created by Dmitry Sachkov on 08.04.2022.
//

import Foundation
import UIKit
import Combine

enum ErrorHandling: Error {
    case parsing(description: String)
    case network(description: String)
}

protocol NetworkServiceProtocol {
    func fetchAllAveliableLeague() -> AnyPublisher<AllLeaguesAvailableModel, Error>
}

class NetworkService {
    
    private let session: URLSession
    private var imageCache = NSCache<NSString, UIImage>()
    
    init(session: URLSession = .shared) {
      self.session = session
    }
}
    
extension NetworkService {
    
    func fetchAllAveliableLeague() -> AnyPublisher<AllLeaguesAvailableModel, Error> {
        return fetchModel(with: baseURL)
    }
    
    func fetchAveliableSeasons(urlString: String) -> AnyPublisher<SeasonsAvailableModel, Error> {
        return fetchModel(with: urlString)
    }
    
    func fetchLeagueStanding(urlString: String) -> AnyPublisher<StandingsModel, Error> {
        return fetchModel(with: urlString)
    }
    
    private func fetchModel<T>(
      with urlString: String
    ) -> AnyPublisher<T, Error> where T: Decodable {
      guard let url = URL(string: urlString) else {
        let error = ErrorHandling.network(description: "Couldn't create URL")
          print(error)
        return Fail(error: error).eraseToAnyPublisher()
      }
        let seeion = URLSession.shared
      return seeion.dataTaskPublisher(for: url)
        .mapError { error in
            ErrorHandling.network(description: error.localizedDescription)
        }
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
//    private func fetchModels<T>(
//      with urlString: String
//    ) -> AnyPublisher<T, Error> where T: Decodable {
//      guard let url = URL(string: urlString) else {
//        let error = ErrorHandling.network(description: "Couldn't create URL")
//          print(error)
//        return Fail(error: error).eraseToAnyPublisher()
//      }
//        let seeion = URLSession.shared
//      return seeion.dataTaskPublisher(for: url)
//        .mapError { error in
//            ErrorHandling.network(description: error.localizedDescription)
//        }
//        .map { $0.data as! T }
//        .decode(type: T.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
//    }
//
//    func fetchData<T: Decodable>(urlStr: String, memberType: T.Type, completionHandler: @escaping (T) -> ()) {
//        guard let url = URL(string: urlStr) else { return }
//        URLSession.shared.dataTask(with: url) {data, _, error in
//            DispatchQueue.main.async {
//                guard let data = data else { return }
//                let tempHTML = String(data: data, encoding: .utf8)!
//                print(tempHTML)
//                do {
////                    let json = try JSONDecoder().decode(T.self, from: someData)
////                    completionHandler(json)
//                }
//                catch let jsonError {
//                    print("Failed to decode json \(jsonError)")
//                }
//            }
//        }.resume()
//    }
//
//
    func fetchImage(urlStr: String, completion: @escaping ((UIImage?) -> Void)) {

        guard let url = URL(string: urlStr) else { return }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Handle Error
                if let error = error {
                    print("Data Task Error: \(error.localizedDescription)")
                return
            }
            guard let image = UIImage(data: data!) else { return }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
                }
            }.resume()
        }
    }
}
