
import SwiftUI
import Combine
import Foundation

extension ContentView {
    
    struct NavigationLinkButton<Content: View > : View {
        
        @StateObject var viewModel = ContentViewModel()
       
        var image: UIImage?
        var fullName: String?
        var content: () -> Content
        
        init(image: UIImage, fullName: String, @ViewBuilder content: @escaping () -> Content) {
            self.image = image
            self.fullName = fullName
            self.content = content
        }
        
        var body: some View {
            NavigationLink(destination: content()) {
                HStack{
                    Image(uiImage: image ?? UIImage())
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                                .cornerRadius(50.0)
                                .padding(.horizontal, 10.0)
                    Text(fullName ?? "")
            }
            }
        }
    }
}
