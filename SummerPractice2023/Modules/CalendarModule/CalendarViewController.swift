import UIKit
import CalendarKit

protocol CalendarViewControllerDelegate: AnyObject {
    func addNewEvent(event: EventModel)
}

class CalendarViewController: DayViewController {

    var events = [EventModel]()
    var addEventClosure: (() -> Void)?
    var showDetailClosure: ((EventModel) -> Void)?
    
    private var networkService = NetworkService()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getEvents { [weak self] result in
            self?.events = result
        }
        title = "Calendar"
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        button.accessibilityIdentifier = "addButtonCalendarVC"
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addEvent() {
        addEventClosure?()
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return events
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        showDetailClosure?(eventModel)
    }
}

extension CalendarViewController: CalendarViewControllerDelegate {
    func addNewEvent(event: EventModel) {
        events.append(event)
        reloadData()
    }
}
