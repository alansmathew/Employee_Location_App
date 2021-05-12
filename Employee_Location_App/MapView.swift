//
//  MapView.swift
//  Employee_Location_App
//
//  Created by Alan S Mathew on 12/05/21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    // these values comes from emp detailes to ShowMap page then to here when map loads
    let id : Int
    let name : String
    let lat : Double
    let lng : Double

    //changing default annotation style
    class Coordinator : NSObject,MKMapViewDelegate{
        var parent : MapView

        init(_ parent : MapView){
            self.parent = parent
        }
        
        func mapView(_ mapView : MKMapView, viewFor annotation : MKAnnotation ) -> MKAnnotationView?{
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil )
            view.canShowCallout = true
            return view
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    

    func makeUIView(context: Context) -> MKMapView {
        let mapView=MKMapView()
        mapView.delegate = context.coordinator
        
        // marking cordinate points with name
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        mapView.addAnnotation(annotation)

        // placing map to center of the point and setting zoom
        let zoomLevel : CLLocationDistance = 900000
        let mapCoordinates = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: zoomLevel, longitudinalMeters: zoomLevel)
        mapView.setRegion(mapCoordinates, animated: true)
        
        //show tittle always
        mapView.selectAnnotation(annotation, animated:true)
        
        return mapView
    }

    // converting to uiViewRepresentable
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(id : 11, name : "london", lat: 51.6, lng: 0.31 )
    }
}
