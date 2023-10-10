//
//  Image+Ext.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import SwiftUI

extension Image {
    func templateImage(width: Double = 18.0, color: Color = .black) -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .foregroundColor(color)
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
    }

    func originalImage(width: Double = 18.0) -> some View {
        self
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
    }
}
