//
//  CountriesListCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MCountriesListCell: View {
    
    @State var title: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.green)
            }
        }
        .background(Color.white)
    }
}
