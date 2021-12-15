//
//  EventDetailInteractor.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventDetailBusinessLogic {
    func startFlow()
    func getAddress()
}

protocol EventDetailDataStore {
    var event: Event? { get set }
}

class EventDetailInteractor: EventDetailDataStore, EventDetailBusinessLogic {
    var event: Event?
    var presenter: EventDetailPresantationLogic?
    var worker: EventDetailWorker = EventDetailWorker()
    
    func startFlow() {
        if let model = event {
            presenter?.presentEventDetail(event: model)
        }
    }
    
    func getAddress() {
        if let model = event {
            worker.getAddress(lat: model.lat!, long: model.long!) { address in
                self.presenter?.presentSuccessGetAddress(address)
            } failure: {
                self.presenter?.presentFailureGetAddress()
            }
        }
    }
}
