//
//  ButtonHelper.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 1/12/22.
//


import SwiftUI

struct SelectionButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .fontWeight(.black)
            .foregroundStyle(LinearGradient(colors: [.white, .white.opacity(0.5), .white], startPoint: .leading, endPoint: .trailing))
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [.clear, .blue], startPoint: .leading, endPoint: .trailing))
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .fill(.black)
            }
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
    }
}
