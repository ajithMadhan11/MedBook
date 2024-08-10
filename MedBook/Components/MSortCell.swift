//
//  MSortCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI

struct MSortCell: View {
    @State var title: String
    @State var isSelected: Bool
    var body: some View {
        Text(title)
            .frame(height: 5)
            .font(MFont.MBold(14))
            .padding()
            .background(isSelected ? MColor.primaryGreen : MColor.lightGray)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .cornerRadius(16)
            
    }
}
