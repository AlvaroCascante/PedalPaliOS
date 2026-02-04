import Foundation

public struct BackendCreateUserRequest: Codable, Equatable {
    public let user: BackendUser
    public let roleName: String

    public init(user: BackendUser, roleName: String) {
        self.user = user
        self.roleName = roleName
    }
}
