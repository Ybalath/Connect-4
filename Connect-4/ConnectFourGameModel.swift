//
//  ConnectFourGameModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation
import SwiftUI



struct ConnectFourGameModel{
    
    private(set) var fields: [[Field]]
    
    private(set) var players: [Player]
    
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
        players = [Player(score: 0, color: Color.blue, name: FieldOwner.player1), Player(score: 0, color: Color.orange, name: FieldOwner.player2)]
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
        players = [Player(score: 0, color: Color.blue, name: FieldOwner.player1), Player(score: 0, color: Color.orange, name: FieldOwner.player2)]
        
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
                fields[firstEmptyFieldInColumns[fieldColumn]][fieldColumn].colorSet = true
                emptyFieldsLeft -= 1
                
                let result = checkForWin(fields[firstEmptyFieldInColumns[fieldColumn]][fieldColumn])
                players[players.firstIndex(where: {$0.name == currentPlayer.name })!].score += result.1
                if result.0 {
                    for i in 0..<result.2.count {
                        fields[result.2[i].0][result.2[i].1].color = Color.green
                    }
                    gameEnd = true
                }else {
                    nextPlayer()
                    victoriusPlayer = currentPlayer.name.rawValue
                }
                firstEmptyFieldInColumns[fieldColumn] -= 1
            }
        }
        
    }
    
    mutating func checkForWin(_ field: Field) -> (Bool,Int,[(Int,Int)]) {
        let directions: [Direction] = [.horizontal,.vertical,.diagonalUp,.diagonalDown]
        var longestLineLength = 0
        for direction in directions {
            let longestLine = longestLineOfFields(field, direction: direction)
            if longestLine.count > longestLineLength{
                longestLineLength = longestLine.count
                
                if longestLineLength >= 4 {
                    return (true,longestLine.count,longestLine)
                }
            }
        }
        return (false,longestLineLength, [])

    }
    
    func longestLineOfFields(_ field: Field, direction: Direction) -> [(Int,Int)]{
        let playerName = field.owner
        let fieldRow = field.id / 7
        let fieldColumn = field.id % 7
        var longestLine = [(Int,Int)]()
        var currentLine = [(Int,Int)]()
        
        switch direction {
        case .horizontal:
            for column in 0..<7{
                if fields[fieldRow][column].owner == playerName {
                    currentLine.append((fieldRow,column))
                } else {
                    if currentLine.count > longestLine.count {
                        longestLine = currentLine
                    }
                    currentLine = []
                }
            }
        case .vertical:
            for row in 0..<6{
                if fields[row][fieldColumn].owner == playerName {
                    currentLine.append((row,fieldColumn))
                } else {
                    if currentLine.count > longestLine.count {
                        longestLine = currentLine
                    }
                    currentLine = []
                }
            }
        case .diagonalUp:
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
                    currentLine.append((row,column))
                    
                } else {
                    if currentLine.count > longestLine.count {
                        longestLine = currentLine
                    }
                    currentLine = []
                }
                row -= 1
                column += 1
            }
        case .diagonalDown:
            var row = fieldRow
            var column = fieldColumn
            if fieldRow >= fieldColumn {
                row = fieldRow - fieldColumn
                column = 0
            } else {
                column = fieldColumn - fieldRow
                row = 0
            }
            while row < 6 && column < 7{
                if fields[row][column].owner == playerName {
                    currentLine.append((row,column))
                    
                } else {
                    if currentLine.count > longestLine.count {
                        longestLine = currentLine
                    }
                    currentLine = []
                }
                row += 1
                column += 1
            }
        }
        if currentLine.count > longestLine.count {
            longestLine = currentLine
        }
        
        return longestLine
        
    }
    
    mutating func nextPlayer(){
        if let currentPlayerIndex = players.firstIndex(where: {$0.name == currentPlayer.name}){
            currentPlayer = players[(currentPlayerIndex+1) % players.count]
        }
    }
    
    
    
    
    
    
    
    
}


