//
//  ConnectFourGameViewModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation
import SwiftUI

class ConnectFourGameViewModel: ObservableObject{
    
    @Published private var model = ConnectFourGameModel()

    var fields: [[Field]]{
        model.fields
    }
    
    func choose(field: Field){
        model.choose(field)
    }
    
    var gameEnd: Bool{
        get { model.gameEnd}
        set { model.gameEnd = newValue}
    }
    
    var currentPlayerName: String{
        model.currentPlayer.name.rawValue
    }
    
    var currentPlayerColor: Color{
        model.currentPlayer.color
    }
    
    var victoriusPlayer: String {
        model.victoriusPlayer
    }
    
    func restartGame() {
        model.restartGame()
    }
    
    var playerScores: (Int,Int){
        return (model.players[0].score,model.players[1].score)
    }
}
