
import Combine
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText: String = ""
    
    var filteredList: [MovieCharacterModel] { viewModel.filterList(with: searchText)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredList, id:\.self) {
                model in
                    NavigationLinkButton(image: viewModel.image[model.imageUrl ?? ""] ?? UIImage(), fullName: model.fullName ?? "", content: {DetailedInformation(image: viewModel.image[model.imageUrl ?? ""] ?? UIImage(), fullName: model.fullName ?? "", title: model.title ?? "", family: model.family ?? "")})
            }
            }
            .navigationTitle("All Characters")
            .foregroundColor(.black)
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
               filteredList
            }
        .onChange(of: searchText) { _ in
          filteredList
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
