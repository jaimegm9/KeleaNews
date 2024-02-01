//
//  Shadow.swift
//
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import SwiftUI

public struct Shadow: ViewModifier {
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}
