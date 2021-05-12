//
//  ShowMap.swift
//  Employee_Location_App
//
//  Created by Alan S Mathew on 12/05/21.
//

import SwiftUI

struct ShowMap: View {
    
    let id : Int
    let name : String
    let lat : Double
    let lng : Double
    
    var body: some View {
        MapView(id : id, name : name, lat: lat, lng: lng ).edgesIgnoringSafeArea(.all)
        
    }
}

struct AddEmployee_Previews: PreviewProvider {
    static var previews: some View {
        ShowMap(id : 11, name : "london", lat: 51.6, lng: 0.31 )
    }
}

