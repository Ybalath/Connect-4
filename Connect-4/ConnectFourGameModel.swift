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
    
    private(set) var fields: [[Field]]
    
    private var players: [Player]
    
    private(set) var currentPlayer: Player
    
    private var emptyFieldsLeft: Int {
        willSet {
            if newValue == 0 {
                gameEnd = true
            }
        }
    }
    private(set) var gameEnd: Bool
    
    init(){
        fields = []
        var id = 0
        players = [Player(score: 0, color: .blue, name: FieldOwner.player1), Player(score: 0, color: .orange, name: FieldOwner.player2)]
        currentPlayer = players.first!
        emptyFieldsLeft = 42
        gameEnd = false
        for _ in 0..<6{
            var row: [Field] = []
            for _ in 0..<7{
                row.append(Field(owner: FieldOwner.none, color: .gray, id: id))
                id += 1
            }
            fields.append(row)
        }
    }
    
    mutating func choose (_ field: Field){
        if field.owner == FieldOwner.none {
            let fieldColumn = field.id % 7
            for rowID in stride(from: 5, through: 0, by: -1){
                if fields[rowID][fieldColumn].owner == FieldOwner.none{
                    fields[rowID][fieldColumn].owner = currentPlayer.name
                    fields[rowID][fieldColumn].color = currentPlayer.color
                    nextPlayer()
                    emptyFieldsLeft -= 1
                    break
                }
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
