import Foundation
import SwiftyJSON

class Parser {
    
    private enum Keys: String {
        case dateStart = "date_start"
        case dateFinish = "date_finish"
        case name = "name"
        case description = "description"
    }
    
    func parseRating(json: JSON) -> [EventModel] {
        var events = [EventModel]()
        for eventInfo in json.arrayValue {
            events.append(parseEventInfo(json: eventInfo))
        }
        return events
    }
    
    private func parseEventInfo(json: JSON) -> EventModel {
        return EventModel( dateInterval: DateInterval(start: Date(timeIntervalSince1970: json[Keys.dateStart.rawValue].doubleValue), end: Date(timeIntervalSince1970: json[Keys.dateFinish.rawValue].doubleValue)), name: json[Keys.name.rawValue].stringValue, description: json[Keys.description.rawValue].stringValue)
    }
}
