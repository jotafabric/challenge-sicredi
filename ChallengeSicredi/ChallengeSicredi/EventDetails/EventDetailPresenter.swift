//
//  EventDetailPresenter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventDetailPresantationLogic {
    func presentationStarFlow()
    func presentationEventDetail(event: Event)
    func presentationGetAddress()
    func presentationSuccessGetAddress(_ address: String)
    func presentationFailureGetAddress()
    func presentationRouteToEventCheckin(eventId: String)
    func presentationRouteToShareEvent(items: [String])
}

protocol EventDetailDataPassing {
    var dataStore: EventDetailDataStore? { get set }
}

class EventDetailPresenter: NSObject, EventDetailPresantationLogic, EventDetailDataPassing {
    
    weak var viewController: EventDetailDisplayLogic?
    
    var interactor: EventDetailBusinessLogic?
    var router: EventDetailRoutingLogic?
    var dataStore: EventDetailDataStore?
    
    func presentationStarFlow(){
        interactor?.startFlow()
    }
    
    func presentationGetAddress(){
        interactor?.getAddress()
    }
    
    func presentationEventDetail(event: Event) {
        let description = event.description ?? ""
        let title = event.title ?? ""
        let price = event.price?.currencyValue ?? ""
        let date = event.date?.intToDateTime?.dateAndTimetoString() ?? ""
        let imageUrl = event.image ?? ""
        let location = ""
        let eventId = event.id ?? ""
        
        let viewModel = EventDetailModels.ViewModel(eventId: eventId, description: description, title: title, price: price, date: date, location: location, imageUrl: imageUrl)
        
        viewController?.displayEventDetails(viewModel: viewModel)
    }
    
    func presentationSuccessGetAddress(_ address: String) {
        viewController?.displayAddress(address)
    }
    
    func presentationFailureGetAddress() {
        viewController?.displayNoAddress()
    }
    
    func presentationRouteToEventCheckin(eventId: String){
        router?.routeToEventCheckin(eventId: eventId)
    }
    
    func presentationRouteToShareEvent(items: [String]){
        router?.routeToShareEvent(items: items)
    }
    
}
