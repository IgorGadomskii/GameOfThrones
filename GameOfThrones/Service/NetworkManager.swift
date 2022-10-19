

import Foundation
import SwiftUI


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager{
    
    
    static var shared = NetworkManager()
        
    init(){}
    
    func fetchSimpleRequest(from url: String,
                      completion: @escaping(Result<[MovieCharacterModel], NetworkError>) -> Void) {
        guard let newUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: newUrl) { data, _, error in
            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let list = try decoder.decode([MovieCharacterModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(list))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}
