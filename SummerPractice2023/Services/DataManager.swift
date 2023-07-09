import Foundation

class DataManager {

    static let shared = DataManager()
    
    private init() { }
    
    var events: [EventModel]?
}
