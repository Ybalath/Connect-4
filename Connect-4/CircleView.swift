//
//  CircleView.swift
//  Connect-4
//
//  Created by Czuchryta, Pawel on 05/01/2024.
//

import SwiftUI

struct CircleView: View {
    var fillColor : Color
    var body: some View {
        Circle()
            .fill()
            .foregroundStyle(.tint)
    }
}

#Preview {
    CircleView(fillColor: .red)
}
