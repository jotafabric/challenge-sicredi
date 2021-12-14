//
//  EventInteractor.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation

protocol EventListBusinessLogic {
    func fetchList()
}

protocol EventListDataStore {
    var events: [Event]? {get set}
}

class EventListInteractor: EventListBusinessLogic, EventListDataStore {
    var events: [Event]?
    var presenter: EventListPresentationLogic?
    var worker: EventWorker = EventWorker()
    
    func fetchList() {
        worker.doFetchEvents { list in
            self.presenter?.presentationSuccessFetchList(model: list)
        } failure: { error in
            self.presenter?.presentationErrorFetchList(error)
        }
    }
}
