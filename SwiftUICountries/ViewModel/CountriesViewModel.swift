//
//  CountriesViewModel.swift
//  SwiftUICountries
//
//  Created by Consultant on 10/30/22.
//

import Foundation

final class CountriesViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    @Published var hasError = false
    @Published var error: CountryError?
    @Published private(set) var isRefreshing = false
    
    func fetchCountries() {
        
        isRefreshing = true
        hasError = false
        
        let countriesUrlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        if let url = URL(string: countriesUrlString) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = CountryError.custom(error: error)
                        }else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // handle properties that look like first_name > firstname
                            
                            if let data = data,
                               let countries = try? decoder.decode([Country].self, from: data) {
                                
                                self?.countries = countries
                                
                            } else {
                                //TODO: handle error
                                self?.hasError = true
                                self?.error = CountryError.failedToDecode
                            }
                            
                        }
                        
                        self?.isRefreshing = false
                    }
                    
                    
                }.resume()
        }
    }
}


extension CountriesViewModel {
    
    enum CountryError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed To Decode Response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
