//
//  CircleView.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import SwiftUI

struct CircleView: View {
    var field: Field
    var body: some View {
        Circle()
            .fill(field.color)
//            .transition(.asymmetric(insertion: .move(edge: .top), removal: .opacity))
            .animation(.easeInOut(duration: 1.0), value: field.colorSet)
    }
}
//
//#Preview {
//    CircleView(fillColor: .red)
//}
