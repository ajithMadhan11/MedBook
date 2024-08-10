//
//  MNavigator.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import Foundation

final class MNavigator: ObservableObject {
    
    @Published var routes = [MRoutes]()
    
    func push(to screen: MRoutes) {
        routes.append(screen)
    }
    
    func goBack() {
        _ = routes.popLast()
    }
    
    func reset() {
        routes = []
    }
    
}
