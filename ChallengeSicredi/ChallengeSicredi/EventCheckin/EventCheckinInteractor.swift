//
//  EventCheckinInteractor.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventCheckinBusinessLogic {
    func startFlow()
    func doPostCheckin(model: EventCheckinModel.ViewModel)
    func validateFields(name: String, email: String)
}

protocol EventCheckinDataSource {
    var eventId: String? { get set }
}

class EventCheckinInteractor: EventCheckinBusinessLogic, EventCheckinDataSource {
    var eventId: String?
    var presenter: EventCheckinPresentationLogic?
    var worker: EventCheckinWorker = EventCheckinWorker()
    
    func startFlow() {
        if let id = eventId {
            presenter?.presentCheckin(eventId: id)
        }
    }
    
    func doPostCheckin(model: EventCheckinModel.ViewModel) {
        worker.doPostCheckin(model) { response in
            self.presenter?.presentCheckinSucces()
        } failure: { error in
            self.presenter?.presentCheckinFailure()
        }
    }
    
    func validateFields(name: String, email: String) {
        if name.isEmpty || email.isEmpty {
            presenter?.presentValueFieldInvalid()
        } else {
            presenter?.presentValueFieldsValid()
        }
    }
}
