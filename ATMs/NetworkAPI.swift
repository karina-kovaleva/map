//
//  NetworkAPI.swift
//  ATMs
//
//  Created by Karina Kovaleva on 27.12.22.
//

import Foundation

protocol NetworkService {
//    func getATMsList(page: Int, completion: @escaping ([Beer]) -> ())
//    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ())
//    func getRandomBeer(completion: @escaping ([Beer]) -> ())
}

class NetworkAPI {

    func getATMsList(completion: @escaping ([ATM]) -> Void) {
        guard let url = URL(string: "https://belarusbank.by/api/atm") else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [unowned self] data, _, _ in
            let decoder = JSONDecoder()
            guard let data = data,
                  let response = try? decoder.decode([ATM].self, from: data) else { return }
            completion(response)
        }
        .resume()
    }
}
