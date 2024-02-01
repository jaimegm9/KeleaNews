//
//  LoadingCellView.swift
//
//
//  Created by jaime.gutierrez.m on 26/11/23.
//

import SwiftUI

public struct LoadingCellView: View {
    
    private enum ViewTraits {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let frame: CGFloat = 57
        static let height: CGFloat = 100
        static let contentHeight: CGFloat = 220
    }
    
    public init() {}
    
    public var body: some View {
        
        ZStack {
            Color.gray.opacity(0.3)
            VStack {
                Spacer()
                VStack {
                    ShimmerView()
                        .frame(height: 40)
                        .cornerRadius(ViewTraits.cornerRadius)
                        .padding([.top, .leading, .trailing], ViewTraits.padding)
                        .padding(.bottom, 5)
                    ShimmerView()
                        .frame(height: 20)
                        .cornerRadius(ViewTraits.cornerRadius)
                        .padding([.bottom, .trailing], ViewTraits.padding)
                        .padding(.leading, ViewTraits.height)
                }
                .frame(height: ViewTraits.height)
                .background(Color.keleaDarkBlue.opacity(0.75))
            }
        }
        .cornerRadius(ViewTraits.cornerRadius)
        .frame(height: ViewTraits.contentHeight)
        .padding([.leading, .trailing], ViewTraits.padding)
        .padding(.bottom, ViewTraits.padding)
    }
}

struct LoadingCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCellView()
    }
}
