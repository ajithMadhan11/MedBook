//
//  MCountrySelect.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MCountrySelect: View {

    @Binding var value: String?
    
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .opacity(0.6)
                .foregroundStyle(MColor.gray)
            Text(value ?? "Select your country")
                .disableAutocorrection(true)
                .font(MFont.MRegular(16))
                .disabled(false)
            Spacer()
            Image(systemName: "chevron.right")
                .opacity(0.6)
                .foregroundStyle(MColor.gray)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12 ,bottomLeading: 12 ,bottomTrailing:  12 ,topTrailing: 12))
                .stroke(MColor.lightGray)
        )
        .background(Color.white)
    }
    
}

