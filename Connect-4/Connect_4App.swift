//
//  Connect_4App.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import SwiftUI

@main
struct Connect_4App: App {
    @StateObject var game = ConnectFourGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
