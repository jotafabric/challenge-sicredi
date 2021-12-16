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
    func presentationFetchList()
    func presentationRouteToEventDetail(model: Event)
}

class EventListPresenter: EventListPresentationLogic {
    
    weak var viewController: EventListDisplayLogic?
    
    var interactor: EventListBusinessLogic?
    var router: EventListRoutingLogic?
    
    func presentationSuccessFetchList(model: [Event]) {
        viewController?.displayEvents(viewModel: model)
    }
    
    func presentationErrorFetchList(_ error: String) {
        viewController?.errorLoadingEvents(error)
    }
    
    func presentationFetchList() {
        interactor?.fetchList()
    }
    
    func presentationRouteToEventDetail(model: Event){
        router?.routeToEventDetail(model: model)
    }
    
}
