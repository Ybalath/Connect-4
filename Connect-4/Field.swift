//
//  Field.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 14/01/2024.
//

import Foundation
import SwiftUI

struct Field: Identifiable, Equatable{
    var owner: FieldOwner
    var color: Color
    let id: Int
    var colorSet: Bool = false
}
