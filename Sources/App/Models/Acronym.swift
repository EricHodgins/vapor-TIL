
import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
    var id: Int? // This is a must
    var short: String
    var long: String
    var userID: User.ID
    
    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

//extension Acronym: Model {
//    typealias Database = SQLiteDatabase
//    typealias ID = Int
//  
//    public static var idKey: IDKey = \Acronym.id
//}

// Improve the above Model
extension Acronym: PostgreSQLModel {}

// TO save the model you must create a table for it. Fluent does this with Migration.
//extension Acronym: Migration {}

// Content - a wrapper around Codeable
extension Acronym: Content {}

extension Acronym: Parameter {} // Powerful type safety to allow parameters as ID 

extension Acronym {
    var user: Parent<Acronym, User> {
        return parent(\.userID)
    }
    
    var categories: Siblings<Acronym, Category, AcronymCategoryPivot> {
        return siblings()
    }
}

// For Foreign Key Constraints
extension Acronym: Migration {
    // Over-rides default
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}
