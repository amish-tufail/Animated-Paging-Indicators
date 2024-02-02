//
//  PagingIndicator.swift
//  AnimatedPagingIndicators
//
//  Created by Amish Tufail on 02/02/2024.
//

import SwiftUI

struct PagingIndicator: View {
    var activeTint: Color = .primary
    var inActiveTint: Color = .primary.opacity(0.15)
    var opactityEffect: Bool = false
    var clipEdges: Bool = false
    var body: some View {
        GeometryReader {
            
            let width = $0.size.width  // Container width
            //$0 means proxy og geometryReader
            
            // Scrollable area width
            if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width, scrollViewWidth > 0 {
                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX // Tells how much scroll is swiped left (negative value)
                let totalPages = Int(width / scrollViewWidth) // This gives total pages (whole width / single page width)
                
                let freeProgress = -minX / scrollViewWidth // can be 1.2, 1.3 like this, how much scroll we have done in terms of page no
                let clippedProgress = min(max(freeProgress, 0.0), CGFloat(totalPages - 1)) // To keep that freeprogress in bound like the first and last can be still increase width so using this we keep value within bounds
                let progress = clipEdges ? clippedProgress : freeProgress // use in Clip Edge Toggle to choose
                
                let activeIndex = Int(progress) // Gives current page
                let nextIndex = Int(progress.rounded(.awayFromZero)) // gives next index/page index
                let indicatorProgress = progress - CGFloat(activeIndex) // Adjust width of current indicator using this
                
                // In Below two we set dynamic width of indicators
                let currentPageWidth = 18 - (indicatorProgress * 18)
                let nextPageWidth = indicatorProgress * 18
                
                HStack(spacing: 10.0) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Circle()
                            .fill(.clear)
                            .frame(width: 8.0 + (activeIndex == index ? currentPageWidth : nextIndex == index ? nextPageWidth : 0.0), height: 8.0)
                            .overlay {
                                ZStack {
                                    Capsule()
                                        .fill(inActiveTint)
                                    Capsule()
                                        .fill(activeTint)
                                        .opacity(opactityEffect ? (activeIndex == index ? 1 - indicatorProgress : nextIndex == index ? indicatorProgress : 0.0) : 1.0)
                                }
                            }
                    }
                }
                .frame(width: scrollViewWidth) // This brings it in center
                .offset(x: -minX) // This allows it remain fix in position and not move when scrolled, basically this reset offset for every page
            }
        }
        .frame(height: 30.0)
    }
}

#Preview {
    ContentView()
}
