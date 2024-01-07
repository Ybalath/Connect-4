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
            Text("Connect 4").font(.title)
            VStack{
                if !viewModel.gameEnd {
                    Text("Current Player: \(viewModel.currentPlayerName)")
                } else{
                    Text("Game Over")
                    viewModel.victoriusPlayer == "Draw" ? Text("Draw") : Text("\(viewModel.victoriusPlayer) won")
                    Button("Play Again"){
                        viewModel.restartGame()
                    }
                }
            }
            gameGrid
        }
        .padding()
//        .alert(isPresented: $viewModel.gameEnd){
//            Alert(title: Text("Game Over - \(viewModel.victoriusPlayer) won"),
//            message: Text("Would you like to play again?"),
//                  primaryButton: .default(Text("Yes")){
//                    viewModel.restartGame()
//            },
//                  secondaryButton: .cancel()
//            )
//        }
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
