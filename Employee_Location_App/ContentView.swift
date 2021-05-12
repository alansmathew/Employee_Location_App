//
//  ContentView.swift
//  iosInternProject
//
//  Created by Alan S Mathew on 12/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var employee: [Row] = []
    @State var page=1
    @State var isLoading : Bool = false
    
    //function is used to update the whole page with the list
    func updateList(){
        Api().getAllEmployee(pageNumber:page) { (employee) in
            self.employee = employee
        }
    }
        
    var body: some View {
        ZStack{
            NavigationView {
                List {
                    ForEach(employee, id:\.id) { emp in
                        NavigationLink(destination: ShowMap(id : emp.id, name : emp.name, lat : emp.lat, lng : emp.lng )) {
                            Text(emp.name)
                                .padding()
                        }
                        }
                    }.onAppear(){
                        updateList()
                    }
                    .navigationBarTitle("EmployeeList")
                    .navigationBarItems(
                        leading:Button("Prev",action: {
                            if(page>1){
                                page-=1
                                isLoading = true
                                updateList()
                                isLoading = false
                            }
                        })
                        ,trailing:Button("Next page",action: {
                            page+=1
                            isLoading = true
                            updateList()
                            isLoading = false
                        })
                )
            }
            if(isLoading){
                LoadingAnimation().onAppear() {
                    LoadingAnimation().animate()
                    Timer.scheduledTimer(withTimeInterval: LoadingAnimation().animationDuration * 1.98, repeats: true) { _ in
                        LoadingAnimation().reset()
                        LoadingAnimation().animate()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
