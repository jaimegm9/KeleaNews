//
//  ShimmerView.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import SwiftUI

public struct ShimmerView: View {
    
    private struct Constants {
        static let duration: Double = 0.7
        static let minOpacity: Double = 0.15
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.keleaDarkBlue)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}

public struct ShimmerView_Previews: PreviewProvider {
    public static var previews: some View {
        VStack {
            ShimmerView()
                .frame(height: 20)
                .cornerRadius(10)
            HStack {
                ShimmerView()
                    .frame(width: 57, height: 57)
                    .cornerRadius(10)
                ShimmerView()
                    .frame(height: 57)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
