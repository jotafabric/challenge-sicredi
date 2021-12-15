//
//  EventCheckinRouter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventCheckinRoutingLogic {
    func routeToSuccessCheckin()
}

protocol EventCheckinDataPassing {
    var dataStore: EventCheckinDataSource? {get set }
}

class EventCheckinRouter: NSObject, EventCheckinRoutingLogic, EventCheckinDataPassing {
    
    weak var viewController: EventCheckinViewController?
    var dataStore: EventCheckinDataSource?
    
    func routeToSuccessCheckin() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
