//
//  EventCheckinWorker.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import Alamofire

class EventCheckinWorker {
    
    func doPostCheckin(_ model: EventCheckinModel.ViewModel, success: @escaping ((String) -> Void), failure: @escaping ((String) -> Void)) {
        
        let url =  "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin"
        let parameters: Parameters = ["eventId": model.eventId, "name": model.personName!, "email": model.personEmail!]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                success(response.result.value.debugDescription)
            }
            if response.result.isFailure {
                failure(response.result.error.debugDescription)
            }
        }
    }
}
