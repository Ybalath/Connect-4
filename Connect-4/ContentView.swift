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
            Text("Current Player: \(viewModel.currentPlayerName)")
            if viewModel.gameEnd {
                Text("Gra skonczona")
            }
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
            ForEach(0..<viewModel.fields.count, id: \.self){ row in
                ForEach(0..<viewModel.fields[row].count, id: \.self){column in
                    let gameField = viewModel.fields[row][column]
                    CircleView(fillColor: gameField.color)
                        .onTapGesture{
                            if !viewModel.gameEnd {
                                viewModel.choose(field: gameField)
                            }
                        }
                        .overlay{
                            Text("\(row) \(column)")
                        }
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}
