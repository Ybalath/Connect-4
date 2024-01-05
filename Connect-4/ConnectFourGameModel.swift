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
    
    init(){
        fields = []
        for i in 0..<42{
            fields.append(Field(owner: FieldOwner.none, color: .gray, id: i))
        }
    }
    
    struct Player{
        var score: Int
    }
    
    struct Field: Identifiable, Equatable{
        var owner: FieldOwner
        var color: Color
        let id: Int
    }
}
