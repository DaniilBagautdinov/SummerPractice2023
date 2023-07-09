import UIKit

final class AppCoordinator: AbstractCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    var coordinators: [AbstractCoordinator] = []
    
    // MARK: - UIWindow
    
    private let window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Start
    
    func start() {
        assemble()
    }
    
    private func assemble() {
        window?.rootViewController = navigationController
        
        let calendarViewController = CalendarViewController()
        
        calendarViewController.addEventClosure = {
            let newEventViewController = NewEventViewController()
            newEventViewController.delegate = calendarViewController
            newEventViewController.dismissClosure = {
                self.navigationController.dismiss(animated: true)
            }
            self.navigationController.present(newEventViewController, animated: true)
        }
        
        calendarViewController.showDetailClosure = { event in
            let detailViewController = DetailViewController()
            detailViewController.event = event
            self.navigationController.show(detailViewController, sender: self)
        }
        
        navigationController.show(calendarViewController, sender: self)
    }
}
