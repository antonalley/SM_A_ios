//
//  LocalSearchService.swift
//  Lonomo
//
//  Created by Anton Alley on 10/17/22.
//

import Foundation
import MapKit
import Combine


struct Landmark: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String{
        self.placemark.name ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
}

class LocalSearchService: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    let locationManager = MapModel()
    var cancellables = Set<AnyCancellable>()
    @Published var landmarks: [Landmark] = []
    @Published var landmark: Landmark?
    
    init() {
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        print(query)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = locationManager.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    print($0.placemark.name!)
                    return Landmark(placemark: $0.placemark)
                }
            }
        }
        
        
    }
}
