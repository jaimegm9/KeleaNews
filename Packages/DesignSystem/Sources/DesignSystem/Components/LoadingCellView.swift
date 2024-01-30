//
//  LoadingCellView.swift
//
//
//  Created by jaime.gutierrez.m on 26/11/23.
//

import SwiftUI

public struct LoadingCellView: View {
    
    private enum ViewTraits {
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let frame: CGFloat = 57
    }
    
    public init() {}
    
    public var body: some View {
        ShimmerView()
            .frame(height: 30)
            .cornerRadius(ViewTraits.cornerRadius)
        HStack {
            ShimmerView()
                .frame(width: ViewTraits.frame, height: ViewTraits.frame)
                .cornerRadius(ViewTraits.cornerRadius)
                .padding(.trailing, ViewTraits.padding)
            ShimmerView()
                .frame(height: ViewTraits.frame)
                .cornerRadius(ViewTraits.cornerRadius)
        }
        .padding(.bottom, ViewTraits.padding)
    }
}

struct LoadingCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCellView()
    }
}
