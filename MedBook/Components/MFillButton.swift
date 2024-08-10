//
//  MFillButton.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import SwiftUI

struct MFillButton: View {
    
    @State var title: String
    
    @State var isPrimary: Bool = false
    
    @State var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            Text(title)
                .foregroundColor(.white)
                .font(MFont.MBold(16))
                .frame(maxWidth: .infinity, minHeight: 58)
                .background(isPrimary ? MColor.primaryGreen : .black)
                .cornerRadius(12)
        }
    }
}
