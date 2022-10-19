
import Combine
import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        
        @Published var image: [String : UIImage] = [:]
        
        @Published private(set) var list: [MovieCharacterModel]?

                
        init(){
            fetchCharacters()
        }
        
        
        private func fetchCharacters() {
            NetworkManager.shared.fetchSimpleRequest(from: "https://thronesapi.com/api/v2/Characters") { result in
                switch result {
                case .success(let peopleData):
                    self.list = peopleData
                    for model in self.list ?? [] {
                        self.getImage(from: model.imageUrl ?? "")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        func getImage(from url: String) {
            NetworkManager.shared.fetchImage(from: url) { result in
                switch result {
                case .success(let imageData):
                    self.image[url] = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
        func filterList(with text: String) -> [MovieCharacterModel] {
            let filteredList: [MovieCharacterModel]
            if text.isEmpty {
                filteredList = list ?? []
            } else {
             filteredList = list?.filter { $0.fullName?.localizedStandardContains(text) ?? true} ?? []
            }
            return filteredList
        }
    }
}






