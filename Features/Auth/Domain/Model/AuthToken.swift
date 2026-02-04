import Foundation

public struct AuthToken: Codable, Equatable {
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Int64

    public init(accessToken: String, refreshToken: String, expiresIn: Int64) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}
