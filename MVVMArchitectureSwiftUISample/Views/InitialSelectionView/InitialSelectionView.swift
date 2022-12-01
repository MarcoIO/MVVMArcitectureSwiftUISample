//
//  InitialSelectionView.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 1/12/22.
//


import SwiftUI

struct InitialSelectionView: View {

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        Group {
                            NavigationLink {
                                MarvelListView()
                            } label: {
                                Text("Marvel List")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .buttonStyle(SelectionButtonStyle())
                            .frame(width: UIScreen.main.bounds.width)
                            NavigationLink {
                                MarvelListView()
                            } label: {
                                Text("Rick and Morty List")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .buttonStyle(SelectionButtonStyle())
                            NavigationLink {
                                MarvelListView()
                            } label: {
                                Text("LastFM List")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .buttonStyle(SelectionButtonStyle())
                        }
                        .navigationBarTitle("Initial Selection", displayMode: .inline)

                    }
                    .padding(.vertical)
                    .frame(width: geometry.size.width)
                    // Make the scroll view full-width
                    .frame(minHeight: geometry.size.height)
                }
            }
        }

    }
}

struct InitialSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        InitialSelectionView()
    }
}
