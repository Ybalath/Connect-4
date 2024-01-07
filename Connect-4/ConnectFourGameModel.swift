//
//  ConnectFourGameModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation
import SwiftUI

enum FieldOwner: String{
    case none = "None"
    case player1 = "Player 1"
    case player2 = "Player 2"
}

struct ConnectFourGameModel{
    
    private(set) var fields: [[Field]]
    
    private var players: [Player]
    
    private(set) var currentPlayer: Player
    
    private var emptyFieldsLeft: Int {
        willSet {
            if newValue == 0 {
                gameEnd = true
                victoriusPlayer = "Draw"
            }
        }
    }
    private(set) var firstEmptyFieldInColumns: [Int]
    var gameEnd: Bool
    var victoriusPlayer: String = ""
    
    init(){
        fields = []
        var id = 0
        players = [Player(score: 0, color: .blue, name: FieldOwner.player1), Player(score: 0, color: .orange, name: FieldOwner.player2)]
        currentPlayer = players.first!
        emptyFieldsLeft = 42
        gameEnd = false
        firstEmptyFieldInColumns = [5,5,5,5,5,5,5]
        for _ in 0..<6{
            var row: [Field] = []
            for _ in 0..<7{
                row.append(Field(owner: FieldOwner.none, color: .gray, id: id))
                id += 1
            }
            fields.append(row)
        }
    }
    mutating func restartGame(){
        fields = []
        var id = 0
        players = [Player(score: 0, color: .blue, name: FieldOwner.player1), Player(score: 0, color: .orange, name: FieldOwner.player2)]
        currentPlayer = players.first!
        emptyFieldsLeft = 42
        gameEnd = false
        victoriusPlayer = ""
        firstEmptyFieldInColumns = [5,5,5,5,5,5,5]
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
            if firstEmptyFieldInColumns[fieldColumn] != -1 {
                fields[firstEmptyFieldInColumns[fieldColumn]][fieldColumn].owner = currentPlayer.name
                fields[firstEmptyFieldInColumns[fieldColumn]][fieldColumn].color = currentPlayer.color
                emptyFieldsLeft -= 1
                
                if checkForWin(fields[firstEmptyFieldInColumns[fieldColumn]][fieldColumn]) {
                    gameEnd = true
                }else {
                    nextPlayer()
                    victoriusPlayer = currentPlayer.name.rawValue
                }
                firstEmptyFieldInColumns[fieldColumn] -= 1
            }
        }
        
    }
    
    mutating func checkForWin(_ field: Field) -> Bool {
        
        let playerName = field.owner
        let fieldRow = field.id / 7
        let fieldColumn = field.id % 7
        
        var count = 0
        for column in 0..<7{
            if fields[fieldRow][column].owner == playerName {
                count += 1
                if count == 4 {
                    return true
                }
            } else {
                count = 0
            }
        }

        count = 0
        for row in 0..<6{
            if fields[row][fieldColumn].owner == playerName {
                count += 1
                if count == 4 {
                    return true
                }
            } else {
                count = 0
            }
        }
        
        count = 0
        var row = fieldRow
        var column = fieldColumn
        if fieldRow + fieldColumn <= 5 {
            row = fieldRow + fieldColumn
            column = 0
        } else {
            row = 5
            column = fieldRow + fieldColumn - 5
        }
        
        while row >= 0 && column < 7{
            if fields[row][column].owner == playerName {
                count += 1
                if count == 4 {
                    return true
                }
            } else {
                count = 0
            }
            row -= 1
            column += 1
        }
        
        count = 0
        if fieldRow >= fieldColumn {
            row = fieldRow - fieldColumn
            column = 0
        } else {
            column = fieldColumn - fieldRow
            row = 0
        }
        while row < 6 && column < 7{
            if fields[row][column].owner == playerName {
                count += 1
                if count == 4 {
                    return true
                }
            } else {
                count = 0
            }
            row += 1
            column += 1
        }
        
        return false
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
