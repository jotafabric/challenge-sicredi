//
//  EventListPresenter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation

protocol EventListPresentationLogic {
    func presentationSuccessFetchList(model: [Event])
    func presentationErrorFetchList(_ error: String)
}

class EventListPresenter: EventListPresentationLogic {
    
    weak var viewController: EventListDisplayLogic?
    
    func presentationSuccessFetchList(model: [Event]) {
        viewController?.displayEvents(viewModel: model)
    }
    
    func presentationErrorFetchList(_ error: String) {
        viewController?.errorLoadingEvents(error)
    }
    
}
