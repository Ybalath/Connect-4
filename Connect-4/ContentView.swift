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
    
    @State private var oldPlayerScore1 = 0
    @State private var oldPlayerScore2 = 0
    
    
    var body: some View {
        VStack {
            Text("Connect 4").font(.title)
            VStack{
                if !viewModel.gameEnd {
                    HStack{
                        Text("Current Player:")
                        Text("\(viewModel.currentPlayerName)")
                            .foregroundStyle(viewModel.currentPlayerColor)
                    }.rotation3DEffect(
                        .degrees(viewModel.currentPlayerName == FieldOwner.player1.rawValue ? 0 : 360), axis: (x: 0, y: 1, z: 0)
                    ).animation(.linear(duration: 1.0), value: viewModel.currentPlayerName)
                } else{
                    Text("Game Over")
                    viewModel.victoriusPlayer == "Draw" ? Text("Draw") : Text("\(viewModel.victoriusPlayer) won")
                    Button("Play Again"){
                        viewModel.restartGame()
                    }
                }
            }
            VStack{
                Text("Score")
                HStack{
                    Text("Player 1")
                    Spacer()
                    Text("Player 2")
                }
                HStack{
                    Text("\(viewModel.playerScores.0)")
                    if viewModel.playerScores.0 > oldPlayerScore1 {
                        Text("+\(viewModel.playerScores.0 - oldPlayerScore1)")
                            .transition(.move(edge: .top))
                            .animation(.easeIn(duration: 0.5))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    self.oldPlayerScore1 = viewModel.playerScores.0
                                }
                            }
                    }
                    Spacer()
                    if viewModel.playerScores.1 > oldPlayerScore2 {
                        Text("+\(viewModel.playerScores.1 - oldPlayerScore2)")
                            .transition(.move(edge: .top))
                            .animation(.easeIn(duration: 0.5))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    self.oldPlayerScore2 = viewModel.playerScores.1
                                }
                            }
                    }
                    Text("\(viewModel.playerScores.1)")
                    
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

//                    CircleView(fillColor: gameField.color)
                    CircleView(field: viewModel.fields[row][column])
                        .onTapGesture{
                            if !viewModel.gameEnd {
                                viewModel.choose(field: viewModel.fields[row][column])
                            }
                        }
//                        .overlay{
//                            Text("\(row) \(column)")
//                        }
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}
