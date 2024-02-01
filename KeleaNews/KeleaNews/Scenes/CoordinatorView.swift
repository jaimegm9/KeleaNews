//
//  CoordinatorView.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import SwiftUI
import DesignSystem

struct CoordinatorView: View {
    @ObservedObject var coordinator: Coordinator
    
    var body: some View {
        NavigationView {
            HomeView(vm: coordinator.homeViewModel)
                .navigation(item: $coordinator.detailViewModel) { detailViewModel in
                    DetailView(vm: detailViewModel)
                }
        }
        .navigationViewStyle(.stack)
        .sheet(item: $coordinator.openedURL) {
            SafariView(url: $0.id)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
