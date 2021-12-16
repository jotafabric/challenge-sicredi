//
//  EventCheckinPresenter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventCheckinPresentationLogic {
    func presentationStarFlow()
    func presentCheckin(eventId: String)
    func presentationDoCheckin(model: EventCheckinModel.ViewModel)
    func presentCheckinSucces()
    func presentCheckinFailure()    
    func presentationValidateFields(name: String, email: String)
    func presentationRouteToCheckinSuccess()
}

protocol EventCheckinDataPassing {
    var dataStore: EventCheckinDataSource? { get set }
}

class EventCheckinPresenter: NSObject, EventCheckinPresentationLogic, EventCheckinDataPassing{
   
    weak var viewController: EventCheckinDisplayLogic?
    var dataStore: EventCheckinDataSource?
    var interactor: EventCheckinBusinessLogic?
    var router: EventCheckinRoutingLogic?
    
    func presentationStarFlow() {
        interactor?.startFlow()
    }
    
    func presentCheckin(eventId: String) {
        viewController?.displayEventIdViewModel(eventId)
    }
    
    func presentationDoCheckin(model: EventCheckinModel.ViewModel){
        interactor?.doPostCheckin(model: model)
    }
    
    func presentCheckinSucces() {
        viewController?.displayEventCheckinSuccess()
    }
    
    func presentCheckinFailure() {
        viewController?.displayEventCheckInFailure()
    }
    
    func presentationValidateFields(name: String, email: String){
        if name.isEmpty || email.isEmpty {
            viewController?.displayValueFieldsInvalid()
        } else {
            viewController?.displayValueFieldsValid()
        }
    }
    
    func presentationRouteToCheckinSuccess(){
        router?.routeToCheckinSuccess()
    }
}
