//
//  HelperComponents.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 1/12/22.
//


import SwiftUI

func sortTypeButton(sortType:Binding<SortType>, action: @escaping () async throws -> Void) -> some View {
    Menu {
        ForEach(SortType.allCases, id:\.self) { type in
            Button {
                Task {
                    try await action()
                }
                sortType.wrappedValue = type
            } label: {
                Text(type.rawValue)
            }
        }
    } label: {
        Text("Sort")
    }
}
