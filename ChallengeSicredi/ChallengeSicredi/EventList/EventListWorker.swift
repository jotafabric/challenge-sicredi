//
//  EventWorker.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation
import Alamofire
import ObjectMapper

class EventWorker {
    
    func doFetchEvents( success: @escaping (([Event]) -> Void), failure: @escaping ((String) -> Void)) {
    
        let url = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                if let list: [Event] = Mapper<Event>().mapArray(JSONObject: response.result.value){
                    success(list)
                }else{
                    failure(response.result.error.debugDescription)
                }
            }
            if response.result.isFailure {
                failure(response.result.error.debugDescription)
            }
        }
        
    }
    
    func doGetEvent(id: String, success: @escaping ((Event) -> Void), failure: @escaping ((String) -> Void)) {
        
        let url = "http://5f5a8f24d44d640016169133.mockapi.io/api/events/\(id)"
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                if let event: Event = Mapper<Event>().map(JSONObject: response.result.value){
                    success(event)
                }else{
                    failure(response.result.error.debugDescription)
                }
            }
            if response.result.isFailure {
                failure(response.result.error.debugDescription)
            }
        }
    }
}
