//
//  EventListRouter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import UIKit

protocol EventListRoutingLogic {
    func routeToEventDetail(model: Event)
}

protocol EventListDataPassing {
    var dataStore: EventListDataStore? { get }
}

class EventListRouter: NSObject, EventListRoutingLogic, EventListDataPassing{
    
    weak var viewController: EventListViewController?
    var dataStore: EventListDataStore?
    
    func routeToEventDetail(model: Event) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController")
            as? EventDetailViewController {
            nextViewController.router?.dataStore?.event = model
            viewController?.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
}
