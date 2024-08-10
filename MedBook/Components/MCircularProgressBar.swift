//
//  MCircularProgressBar.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MCircularProgressBar: View {
        
        @Binding var progress: Float
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 5)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemGray3))
                Circle()
                    .trim(from: 0.0 , to: CGFloat(min(self.progress, 100)))
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .foregroundColor(MColor.primaryGreen)
                    .rotationEffect(Angle(degrees: 270.0))
            }
            .padding()
        }
}
