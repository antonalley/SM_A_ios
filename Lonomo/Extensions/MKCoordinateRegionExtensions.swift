//
//  MKCoordinateRegionExtensions.swift
//  Lonomo
//
//  Created by Anton Alley on 10/17/22.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 40.2338, longitude: -111.6585), span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
}
