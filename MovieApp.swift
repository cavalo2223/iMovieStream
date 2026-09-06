import SwiftUI
@main
struct MovieApp: App {
    private let apiKey = "6d531b73001df43eed9ee25df5e4d3af" // Substitui pela chave TMDb
    var body: some Scene {
        WindowGroup { HomeView(apiKey: apiKey) }
    }
}
