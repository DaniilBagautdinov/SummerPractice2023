import Foundation
import SwiftyJSON

typealias Completion = (([EventModel]) -> Void)?

class NetworkService {
    
    private var parser = Parser()
    
    func getEvents(completion: Completion) {
        if let url = Bundle.main.url(forResource: "file", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                completion?(parser.parseRating(json: JSON(data)))
            } catch {
                print("error:\(error)")
            }
        }
    }
}
