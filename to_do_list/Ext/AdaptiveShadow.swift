//
//  AdaptiveShadow.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 15/07/2025.
//

import SwiftUI

struct AdaptiveShadow: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .shadow(
                    color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3),
                    radius: 5, x: 0, y: 2
                )
    }
}

extension View {
    func adaptiveShadow() -> some View {
        self.modifier(AdaptiveShadow())
    }
}
