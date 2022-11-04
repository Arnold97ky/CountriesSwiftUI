//
//  ContentView.swift
//  SwiftUICountries
//
//  Created by Consultant on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CountriesViewModel()
    var filteredData = [Country]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack{
               
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    
                    List {
                        ForEach(vm.countries, id: \.name) { country in
                            
                            CountryView(country: country)
                                .listRowSeparator(.hidden)
                        }
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Countries")
                    .searchable(text: $searchText, prompt: "Find a country")
                    
                    
                }
                
            }
            .onAppear(perform: vm.fetchCountries)
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button(action: vm.fetchCountries) {
                    Text("Retry")
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
