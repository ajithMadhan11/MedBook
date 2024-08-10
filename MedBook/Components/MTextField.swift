//
//  MTextField.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import SwiftUI

struct MTextField: View {
    
    @State var isPassword: Bool = false
    @State var title: String
    @State var imageName: String
    @Binding var value: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .opacity(0.6)
                .foregroundStyle(MColor.gray)
            if isPassword {
                SecureField(title , text: $value)
                    .textContentType(.password)
                    .disabled(false)
            } else {
                TextField(title , text: $value)
                    .textContentType(.emailAddress)
                    .font(MFont.MRegular(16))
            }
        }
        .padding()
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12 ,bottomLeading: 12 ,bottomTrailing:  12 ,topTrailing: 12))
                .stroke(MColor.lightGray)
        )
    }
    
}

