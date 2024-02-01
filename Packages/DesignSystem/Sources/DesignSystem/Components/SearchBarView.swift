//
//  SearchBarView.swift
//
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import SwiftUI

public struct SearchBarView: View {
    
    private enum ViewTraits {
        static let paddingH: CGFloat = 16
        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 15
    }
    
    @Binding var searchText: String
    @FocusState var isFocused: Bool
    let search: () -> Void

    public init(searchText: Binding<String>, isFocused: FocusState<Bool>, search: @escaping () -> Void) {
        self._searchText = searchText
        self._isFocused = isFocused
        self.search = search
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.keleaOrange)
            TextField("Search", text: $searchText)
                .focused($isFocused)
                .onSubmit {
                    search()
                }
        }
        .padding(ViewTraits.padding)
        .overlay(RoundedRectangle(cornerRadius: ViewTraits.cornerRadius)
                    .stroke(Color.keleaDarkBlue, lineWidth: 2))
        .padding([.leading, .trailing], ViewTraits.paddingH)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), isFocused: FocusState<Bool>(), search: {})
}
