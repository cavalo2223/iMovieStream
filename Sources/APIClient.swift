import Foundation
enum APIError: Error { case invalidURL, noData, decodingError, networkError(Error) }
class APIClient {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey: String
    init(apiKey: String) { self.apiKey = apiKey }
    func fetchMovies(endpoint: String = "now_playing") async throws -> [Movie] {
        let urlString = "\(baseURL)/movie/\(endpoint)?api_key=\(apiKey)&language=pt-BR&page=1"
        return try await fetch(urlString: urlString, responseType: MovieResponse.self).results
    }
    func fetchTVShows(endpoint: String = "popular") async throws -> [TVShow] {
        let urlString = "\(baseURL)/tv/\(endpoint)?api_key=\(apiKey)&language=pt-BR&page=1"
        return try await fetch(urlString: urlString, responseType: TVShowResponse.self).results
    }
    private func fetch<T: Codable>(urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder(); decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch { throw APIError.networkError(error) }
    }
}
