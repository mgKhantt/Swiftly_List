//
//  NoItemsView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 10/07/2025.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("No Items Yet!")
                .font(.title)
                .fontWeight(.semibold)

            Text("It seems you've completed all your tasks! 🎉")
                .font(.headline)
                .padding(.bottom, 20)
            Text("Go add some! 🚀")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .transition(AnyTransition.opacity.animation(.easeIn))
    }
}

#Preview {
    NoItemsView()
}
