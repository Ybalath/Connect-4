//
//  ConnectFourGameViewModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation

class ConnectFourGameViewModel: ObservableObject{
    
    @Published private var model = ConnectFourGameModel()

    var fields: [[ConnectFourGameModel.Field]]{
        model.fields
    }
    
    func choose(field: ConnectFourGameModel.Field){
        model.choose(field)
    }
    
    var gameEnd: Bool{
        model.gameEnd
    }
    
    var currentPlayerName: String{
        switch model.currentPlayer.name {
        case .none:
            return "No player"
        case .player1:
            return "Player 1"
        case .player2:
            return "Player 2"
        }
    }
}
