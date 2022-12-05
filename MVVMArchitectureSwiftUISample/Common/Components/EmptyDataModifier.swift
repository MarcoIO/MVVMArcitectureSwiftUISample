//
//  EmptyDataModifier.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 5/12/22.
//


import SwiftUI

struct EmptyDataModifier<Placeholder: View>: ViewModifier {

    let items: [Any]
    let placeholder: Placeholder

    @ViewBuilder
    func body(content: Content) -> some View {
        if !items.isEmpty {
            content
        } else {
            placeholder
        }
    }
}

extension List {

    func emptyListPlaceholder(_ items: [Any], _ placeholder: AnyView) -> some View {
        modifier(EmptyDataModifier(items: items, placeholder: placeholder))
    }
}
