import Foundation

// MARK: - ActorExternalIDs
struct ActorExternalIDs: Codable, SocialMediaProtocol {
    var id: Int?
    var freebaseMid, freebaseID, imdbID: String?
    var tvrageID: Int?
    var wikidataID, facebookID, instagramID, tiktokID: String?
    var twitterID: String?
    var youtubeID: String?
    
    // Sosial media linkləri
    var facebookURL: String? {
        return facebookID != nil ? "https://facebook.com/\(facebookID!)" : nil
    }

    var instagramURL: String? {
        return instagramID != nil ? "https://instagram.com/\(instagramID!)" : nil
    }

    var twitterURL: String? {
        return twitterID != nil ? "https://twitter.com/\(twitterID!)" : nil
    }

    var tiktokURL: String? {
        return tiktokID != nil ? "https://tiktok.com/@\(tiktokID!)" : nil
    }

    var youtubeURL: String? {
        return youtubeID != nil ? "https://youtube.com/\(youtubeID!)" : nil
    }
    
    // CodingKeys – JSON ilə uyğunlaşma üçün
    enum CodingKeys: String, CodingKey {
        case id
        case freebaseMid = "freebase_mid"
        case freebaseID = "freebase_id"
        case imdbID = "imdb_id"
        case tvrageID = "tvrage_id"
        case wikidataID = "wikidata_id"
        case facebookID = "facebook_id"
        case instagramID = "instagram_id"
        case tiktokID = "tiktok_id"
        case twitterID = "twitter_id"
        case youtubeID = "youtube_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

