//
//  ChooseLocationView.swift
//  Lonomo
//
//  Created by Anton Alley on 10/17/22.
//

import SwiftUI
import MapKit

struct ChooseLocationView: View {
    @StateObject private var viewModel = MapModel()
    @EnvironmentObject var search_service: LocalSearchService
    @State var mapSearch = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass").padding()
                TextField("Search", text:$mapSearch)
                    .onSubmit {
                        //Search nearby places
                        search_service.search(query:mapSearch)
                    }
                Spacer()
            }.foregroundColor(Color.gray)
                .frame(width:partial_width(percent: 0.95), height:50)
                .background(Color(UIColor(named:"BoxedColor") ?? .gray))
                .cornerRadius(10)
                .padding()
            
            if !search_service.landmarks.isEmpty{
                List(search_service.landmarks) {landmark in
                    VStack{
                        Text(landmark.name)
                    }.listRowBackground(search_service.landmark == landmark ? Color(UIColor(named:"BoxedColor") ?? .gray).opacity(0.5) : Color(UIColor(named:"BoxedColor") ?? .gray))
                        .onTapGesture {
                            search_service.landmark = landmark
                            withAnimation {
                                search_service.region = MKCoordinateRegion.regionFromLandmark(landmark)
                            }
                        }
                }.frame(height:150)
            } else {
                //TODO ?
            }
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: search_service.landmarks) { landmark in
                 MapAnnotation(coordinate:landmark.coordinate) {
                     if landmark == search_service.landmark {
                         Image(systemName: "mappin.square.fill")
                         Text(landmark.name)
                     }
                }
               
                
            }
            .onAppear(){
                viewModel.checkIfLocationServicesIsEnabled()
            
            }
        }
    }
}

struct ChooseLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLocationView()
    }
}


final class MapModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else{
            print("Show some alert") // TODO
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted likely due to parental controls")
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("You have denied this app location permission. Go to settings to change it")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
