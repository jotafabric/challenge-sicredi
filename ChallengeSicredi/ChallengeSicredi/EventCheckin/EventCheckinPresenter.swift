//
//  EventCheckinPresenter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventCheckinPresentationLogic {
    func presentCheckin(eventId: String)
    func presentCheckinSucces()
    func presentCheckinFailure()
    func presentValueFieldsValid()
    func presentValueFieldInvalid()
}

class EventCheckinPresenter: EventCheckinPresentationLogic {
    weak var viewController: EventCheckinDisplayLogic?
    
    func presentCheckin(eventId: String) {
        viewController?.displayEventIdViewModel(eventId)
    }
    
    func presentCheckinSucces() {
        viewController?.displayEventCheckinSuccess()
    }
    
    func presentCheckinFailure() {
        viewController?.displayEventCheckInFailure()
    }
    
    func presentValueFieldsValid() {
        viewController?.displayValueFieldsValid()
    }
    
    func presentValueFieldInvalid() {
        viewController?.displayValueFieldsInvalid()
    }
}
