import Foundation

struct Task: Identifiable, Codable {
    let id: UUID = UUID() // Unique identifier for each task
    let title: String
    var isCompleted: Bool
}
