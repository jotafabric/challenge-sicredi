//
//  Event.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation
import ObjectMapper

class Event: Mappable {
    
    var people: [Person]?
    var date: Int?
    var description: String?
    var image: String?
    var lat: Double?
    var long: Double?
    var price: Double?
    var title: String?
    var id: String?
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        people = map.JSON["people"] as? [Person]
        date = map.JSON["date"] as? Int
        description = map.JSON["description"] as? String
        image = map.JSON["image"] as? String
        lat = map.JSON["latitude"] as? Double
        long = map.JSON["longitude"] as? Double
        price = map.JSON["price"] as? Double
        title  = map.JSON["title"] as? String
        id = map.JSON["id"] as? String
    }
}

class Person: Mappable {
    var name: String?
    var email: String?
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name = map.JSON["name"] as? String
        email = map.JSON["email"] as? String
    }
}
