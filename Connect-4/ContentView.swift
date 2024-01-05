//
//  ContentView.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import SwiftUI


let gameFields = Array(repeating: 0, count: 42)


struct ContentView: View {
    
    @ObservedObject var viewModel: ConnectFourGameViewModel = ConnectFourGameViewModel()
    
    var body: some View {
        VStack {
            Text("Connect 4")
            gameGrid
        }
        .padding()
    }
    var gameGrid: some View {
        let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        return LazyVGrid(columns: columns){
            ForEach(viewModel.fields){
                gameField in
                CircleView()
            }
        }
    }
}
#Preview {
    ContentView()
}
