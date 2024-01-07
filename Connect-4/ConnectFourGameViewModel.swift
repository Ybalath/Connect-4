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
        get { model.gameEnd}
        set { model.gameEnd = newValue}
    }
    
    var currentPlayerName: String{
        model.currentPlayer.name.rawValue
    }
    
    var victoriusPlayer: String {
        model.victoriusPlayer
    }
    
    func restartGame() {
        model.restartGame()
    }
}
