import SwiftUI
@MainActor
class HomeViewModel: ObservableObject {
    @Published var featuredItem: MediaDisplayable?
    @Published var popularItems: [MediaDisplayable] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let apiClient: APIClient
    init(apiKey: String) {
        self.apiClient = APIClient(apiKey: apiKey)
        Task { await loadHome() }
    }
    func loadHome() async {
        isLoading = true; defer { isLoading = false }
        async let moviesTask = apiClient.fetchMovies()
        async let tvTask = apiClient.fetchTVShows()
        do {
            let (movies, shows) = try await (moviesTask, tvTask)
            if let first = movies.first { self.featuredItem = first }
            else if let first = shows.first { self.featuredItem = first }
            let all: [MediaDisplayable] = (movies as [MediaDisplayable]) + (shows as [MediaDisplayable])
            self.popularItems = all.sorted { ($0.rating ?? 0) > ($1.rating ?? 0) }.prefix(10).map { $0 }
        } catch { self.errorMessage = "Falha: \(error.localizedDescription)" }
    }
    func refresh() async { await loadHome() }
}
