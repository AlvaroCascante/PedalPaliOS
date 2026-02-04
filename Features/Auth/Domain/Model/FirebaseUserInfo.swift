import Foundation

/// Domain model representing a Firebase-authenticated user snapshot on iOS
public struct FirebaseUserInfo: Codable, Equatable {
    public let uid: String
    public let email: String?
    public let displayName: String?
    public let isEmailVerified: Bool

    public init(uid: String, email: String?, displayName: String?, isEmailVerified: Bool) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.isEmailVerified = isEmailVerified
    }
}
