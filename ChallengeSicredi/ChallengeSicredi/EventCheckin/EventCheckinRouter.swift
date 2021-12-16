//
//  EventCheckinRouter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventCheckinRoutingLogic {
    func routeToCheckinSuccess()
}

class EventCheckinRouter: EventCheckinRoutingLogic {
    
    weak var viewController: EventCheckinViewController?
    
    func routeToCheckinSuccess() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
