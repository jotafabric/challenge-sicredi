//
//  EventDetailsRouter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventDetailRoutingLogic {
    func routeToEventCheckin()
}

protocol EventDetailDataPassing {
    var dataStore: EventDetailDataStore? { get set }
}

class EventDetailRouter: NSObject, EventDetailRoutingLogic, EventDetailDataPassing {

    weak var viewController: EventDetailViewController?
    var dataStore: EventDetailDataStore?
    
    func routeToEventCheckin() {
        //<#code#>
    }
    
}
