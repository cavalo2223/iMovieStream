import Foundation
protocol MediaDisplayable {
    var id: Int { get }
    var title: String { get }
    var overview: String? { get }
    var posterURL: URL? { get }
    var year: String { get }
    var rating: Double? { get }
    var mediaType: String { get }
}
struct Movie: Codable, MediaDisplayable {
    let id: Int; let title: String; let overview: String?; let posterPath: String?
    let releaseDate: String?; let voteAverage: Double?
    var posterURL: URL? { guard let path = posterPath else { return nil }; return URL(string: "https://image.tmdb.org/t/p/w500\(path)") }
    var year: String { return String(releaseDate?.prefix(4) ?? "----") }
    var mediaType: String { return "movie" }
    enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path", releaseDate = "release_date", voteAverage = "vote_average"
    }
}
struct TVShow: Codable, MediaDisplayable {
    let id: Int; let name: String; let overview: String?; let posterPath: String?
    let firstAirDate: String?; let voteAverage: Double?
    var posterURL: URL? { guard let path = posterPath else { return nil }; return URL(string: "https://image.tmdb.org/t/p/w500\(path)") }
    var year: String { return String(firstAirDate?.prefix(4) ?? "----") }
    var mediaType: String { return "tv" }
    enum CodingKeys: String, CodingKey {
        case id, name, overview, posterPath = "poster_path", firstAirDate = "first_air_date", voteAverage = "vote_average"
    }
}
struct MovieResponse: Codable { let results: [Movie] }
struct TVShowResponse: Codable { let results: [TVShow] }
