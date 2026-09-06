import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    init(apiKey: String) { _viewModel = StateObject(wrappedValue: HomeViewModel(apiKey: apiKey)) }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Série").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                        Spacer()
                        Text("FILMES").font(.title3).fontWeight(.semibold).foregroundColor(.gray)
                            .padding(.horizontal,12).padding(.vertical,6)
                            .background(Color.gray.opacity(0.2)).clipShape(Capsule())
                    }.padding(.horizontal,20).padding(.top,8).padding(.bottom,12)
                    if let featured = viewModel.featuredItem {
                        FeaturedCard(item: featured).padding(.horizontal,16).padding(.bottom,24)
                    } else if viewModel.isLoading { ProgressView().frame(height:200) }
                    HStack {
                        Text("Novidades Mais Populares").font(.title2).fontWeight(.bold).foregroundColor(.white)
                        Spacer()
                        Button("Ver tudo") {}.font(.subheadline).foregroundColor(.blue)
                    }.padding(.horizontal,20).padding(.bottom,8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:16) {
                            if viewModel.popularItems.isEmpty && viewModel.isLoading {
                                ForEach(0..<5, id:\.self) { _ in
                                    RoundedRectangle(cornerRadius:12).fill(Color.gray.opacity(0.2)).frame(width:140,height:200)
                                }
                            } else {
                                ForEach(viewModel.popularItems, id:\.id) { item in
                                    PopularCard(item: item).frame(width:150)
                                }
                            }
                        }.padding(.horizontal,20).padding(.bottom,20)
                    }
                    Spacer(minLength:40)
                }
            }.background(Color.black.ignoresSafeArea())
            .refreshable { await viewModel.refresh() }
            .alert("Erro", isPresented:.constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: { Text(viewModel.errorMessage ?? "") }
        }
    }
}
