//
//  EventDetailsRouter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import UIKit

protocol EventDetailRoutingLogic {
    func routeToEventCheckin(eventId: String)
    func routeToShareEvent(title: String, address: String, date: String)
}

protocol EventDetailDataPassing {
    var dataStore: EventDetailDataStore? { get set }
}

class EventDetailRouter: NSObject, EventDetailRoutingLogic, EventDetailDataPassing {
    
    weak var viewController: EventDetailViewController?
    var dataStore: EventDetailDataStore?
    
    func routeToEventCheckin(eventId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "EventCheckinViewController")
            as? EventCheckinViewController {
            nextViewController.router?.dataStore?.eventId = eventId
            
            if let sheet = nextViewController.sheetPresentationController {
                sheet.detents = [ .medium() ]
            }
            
            viewController?.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func routeToShareEvent(title: String, address: String, date: String) {
        let items = [title, address, date]
        let action = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController?.present(action, animated: true)
    }
    
}