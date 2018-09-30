
import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
    var id: Int? // This is a must
    var short: String
    var long: String
    
    init(short: String, long: String) {
        self.short = short
        self.long = long
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
extension Acronym: Migration {}

// Content - a wrapper around Codeable
extension Acronym: Content {}

extension Acronym: Parameter {}
