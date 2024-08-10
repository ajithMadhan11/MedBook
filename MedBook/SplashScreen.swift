//
//  SplashScreen.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false
    var body: some View {
        ZStack {
            if isActive {
                NavigationView{
                    ContentView()
                }
            } else {
                VStack {
                    LottieView(loopMode: .playOnce, animationName: "books")
                        .frame(width: 200, height: 220)
                        .clipped()
                    Text("MedBooks")
                        .font(MFont.MBold(40))
                        .padding(.top, 20)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
