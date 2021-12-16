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

class EventListRouter: EventListRoutingLogic{
    
    weak var viewController: EventListViewController?
    
    func routeToEventDetail(model: Event) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController")
            as? EventDetailViewController {
            nextViewController.presenter?.dataStore?.event = model
            viewController?.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
}
