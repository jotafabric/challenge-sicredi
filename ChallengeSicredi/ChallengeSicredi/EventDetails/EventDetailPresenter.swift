//
//  EventDetailPresenter.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

protocol EventDetailPresantationLogic {
    func presentEventDetail(event: Event)
    func presentSuccessGetAddress(_ address: String)
    func presentFailureGetAddress()
}

class EventDetailPresenter: EventDetailPresantationLogic {
    
    weak var viewController: EventDetailDisplayLogic?
    
    func presentEventDetail(event: Event) {
        let description = event.description ?? ""
        let title = event.title ?? ""
        let price = event.price?.currencyValue ?? ""
        let date = event.date?.intToDateTime?.dateAndTimetoString() ?? ""
        let imageUrl = event.image ?? ""
        let location = ""
        
        let viewModel = EventDetailModels.ViewModel(description: description, title: title, price: price, date: date, location: location, imageUrl: imageUrl)
        
        viewController?.displayEventDetails(viewModel: viewModel)
    }
    
    func presentSuccessGetAddress(_ address: String) {
        viewController?.displayAddress(address)
    }
    
    func presentFailureGetAddress() {
        viewController?.displayNoAddress()
    }
    
}
