//
//  CountryView.swift
//  SwiftUICountries
//
//  Created by Consultant on 10/30/22.
//

import SwiftUI

struct CountryView: View {
    let country: Country
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("\(country.name),")
                
                HStack{
                    Text(" \(country.region)")
                    Text("\(country.code)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
          //  Divider()
            Text("\(country.capital)")
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
        
        
            }
}


struct CountryView_Previewa: PreviewProvider {
    static var previews: some View {
        CountryView(country: .init(capital: "Ouaga", code: "BF", flag: "Link", name: "Burkina faso", region: "NA"))
    }
}
