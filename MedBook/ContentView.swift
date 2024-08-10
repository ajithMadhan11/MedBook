//
//  ContentView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI
import Combine
import SwiftData

struct ContentView: View {
    @State var isAuthenticated = AuthHandler.IsAuthenticated()
    var body: some View {
        Group {
            if isAuthenticated {
                MHomeView()
                    .environmentObject(MNavigator())
            } else {
                MAuthView()
            }
        }
        .modelContainer(for: [User.self, Book.self])
        .onReceive(AuthHandler.Authenticated, perform: { value in
            if value == false {
                MUserDefaultsUtil.shared.resetData()
            }
            isAuthenticated = value
        })
    }
}
