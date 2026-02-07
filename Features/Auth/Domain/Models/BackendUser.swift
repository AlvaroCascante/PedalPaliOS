import Foundation

public struct BackendUser: Codable, Equatable {
    public let username: String
    public let nickname: String
    public let person: BackendPerson

    public init(username: String, nickname: String, person: BackendPerson) {
        self.username = username
        self.nickname = nickname
        self.person = person
    }
}
