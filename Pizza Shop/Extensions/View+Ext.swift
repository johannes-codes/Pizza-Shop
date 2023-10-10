//
//  View+Ext.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import SwiftUI

// MARK: - Fade Out
extension View {
    func fadeOutTop(fadeLength: CGFloat = 50) -> some View {
        return mask(
            VStack(spacing: 0) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0), Color.black]),
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: fadeLength)

                Rectangle().fill(Color.black)
            }
        )
    }
}

// MARK: - Shadow Modifier
struct DropShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.25), radius: 10, x: -5.0, y: 5.0)
    }
}

extension View {
    func dropShadow() -> some View {
        modifier(DropShadow())
    }
}

// MARK: - Border Extension
struct Border: ViewModifier {
    func body(content: Content) -> some View {
        content
            .border(Constant.primary, width: 1.0)
    }
}

extension View {
    func border() -> some View {
        modifier(Border())
    }
}
