//
//  EventCheckinModels.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation

enum EventCheckinModel {
    
    struct ViewModel {
        var eventId: String
        var personName: String?
        var personEmail: String?
        
        init(eventId: String){
            self.eventId = eventId
        }
    }
}
