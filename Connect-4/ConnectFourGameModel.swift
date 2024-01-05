//
//  ConnectFourGameModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation
import SwiftUI

enum FieldOwner{
    case none
    case player1
    case player2
}

struct ConnectFourGameModel{
    
    private(set) var fields: [Field]
    
    private var players: [Player]
    
    private(set) var currentPlayer: Player
    
    init(){
        fields = []
        players = [Player(score: 0, color: .blue, name: FieldOwner.player1), Player(score: 0, color: .orange, name: FieldOwner.player2)]
        currentPlayer = players.first!
        for i in 0..<42{
            fields.append(Field(owner: FieldOwner.none, color: .gray, id: i))
        }
    }
    
    mutating func choose (_ field: Field){
        if let chosenFieldIndex = fields.firstIndex(where: {$0.id == field.id}){
            if fields[chosenFieldIndex].owner == FieldOwner.none{
                fields[chosenFieldIndex].owner = currentPlayer.name
                fields[chosenFieldIndex].color = currentPlayer.color
                nextPlayer()
            }
        }
    }
    
    mutating func nextPlayer(){
        if let currentPlayerIndex = players.firstIndex(where: {$0.name == currentPlayer.name}){
            currentPlayer = players[(currentPlayerIndex+1) % players.count]
        }
    }
    
    struct Player{
        let score: Int
        let color: Color
        let name: FieldOwner
    }
    
    struct Field: Identifiable, Equatable{
        var owner: FieldOwner
        var color: Color
        let id: Int
    }
}
