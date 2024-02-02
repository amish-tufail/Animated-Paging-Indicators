//
//  Home.swift
//  AnimatedPagingIndicators
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct Home: View {
    @State private var colors: [Color] = [.red, .cyan, .pink, .yellow, .orange]
    @State private var opacity: Bool = false
    @State private var clip: Bool = false
    
    var body: some View {
        VStack {
            // Paging View
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0.0) { // Spacing fixes distance issue
                    ForEach(colors, id:\.self) { color in
                        RoundedRectangle(cornerRadius: 28.0)
                            .fill(color)
                            .padding(.horizontal, 15.0)
                            .containerRelativeFrame(.horizontal) // This makes it expand to whole width
                    }
                }
                .overlay(alignment: .bottom) {
                    PagingIndicator(activeTint: .white, inActiveTint: .black.opacity(0.25), opactityEffect: opacity, clipEdges: clip)
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging) // This creates that paging effect on this, which we get with TabView
            .frame(height: 220.0)
            .padding(.top, 15.0)
            // Paging View End
            List {
                Toggle("Opacity Effect", isOn: $opacity)
                Toggle("Clip Edges", isOn: $clip)
                Button {
                    colors.append(.purple)
                } label: {
                    Text("Add Item")
                }
            }
//            .clipShape(RoundedRectangle(cornerRadius: 15.0)) // Same as below
            .clipShape(.rect(cornerRadius: 15.0))
            .padding(15.0)
        }
        .navigationTitle("Custom Indicators 🤓")
    }
}

#Preview {
    NavigationView {
        Home()
    }
}
