//
//  ConnectFourGameViewModel.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import Foundation

class ConnectFourGameViewModel: ObservableObject{
    
    @Published private var model = ConnectFourGameModel()

    var fields: [ConnectFourGameModel.Field]{
        model.fields
    }
}
