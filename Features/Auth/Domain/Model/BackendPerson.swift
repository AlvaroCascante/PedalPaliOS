import Foundation

public struct BackendPerson: Codable, Equatable {
    public let idNumber: String
    public let name: String
    public let lastname: String

    public init(idNumber: String, name: String, lastname: String) {
        self.idNumber = idNumber
        self.name = name
        self.lastname = lastname
    }
}
