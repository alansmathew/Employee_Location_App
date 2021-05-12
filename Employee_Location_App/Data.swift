//
//  Data.swift
//  Employee_Location_App
//
//  Created by Alan S Mathew on 12/05/21.
//

import SwiftUI

struct Response: Codable {
    let rows: [Row]
    let total, page, pageSize, totalPages: Int
}

// EmpData
struct Row: Codable {
    let id: Int
    let name: String
    let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, lat, lng
    }
}

class Api{
    
//this function will fetch data from api and and sets to row array
    func getAllEmployee(pageNumber:Int,completion: @escaping ([Row]) -> ()) {
        let tempurl = "http://nats.dev.vs.iinerds.com:8080/api/locations?page="+String(pageNumber)
        guard let url = URL(string: tempurl ) else{return}
        URLSession.shared.dataTask(with: url) { (data, respinse, error) in
            guard let empData = data else { return }
            do {
                let employee = try JSONDecoder().decode(Response.self, from: empData)
                completion(employee.rows)
//                DispatchQueue.main.async {
//                    completion(employee.rows)
//                }
//                print(tempurl)
//                print(employee.rows)
            }
            catch {
                print(error)
            }
        }.resume()
    }
}

