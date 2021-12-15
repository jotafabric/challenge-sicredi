//
//  EventDetailWorker.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import MapKit

class EventDetailWorker {
    
    func getAddress(lat: Double, long: Double , success: @escaping ((String) -> Void), failure: @escaping (() -> Void)) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        center.latitude = lat
        center.longitude = long
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        let ceo: CLGeocoder = CLGeocoder()
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil){
                print("EventDetailWorker: [Error] -> \(error!.localizedDescription)")
                failure()
            }
            
            let pm = placemarks! as [CLPlacemark]
            var addressString : String = ""
            
            if pm.count > 0 {
                let pm = placemarks![0]
                
                if let thoroughfare = pm.thoroughfare {
                    addressString = addressString + "\(thoroughfare), "
                }
                
                if let subThoroughfare = pm.subThoroughfare {
                    addressString = addressString + "\(subThoroughfare) - "
                }
                
                if let postalCode = pm.postalCode {
                    addressString = addressString + "CEP \(postalCode), "
                }
                
                if let locality = pm.locality {
                    addressString = addressString + locality + ", "
                }
                
                if let country = pm.country {
                    addressString = addressString + "\(country)"
                }
            }
            success(addressString)
        })
    }
    
}
