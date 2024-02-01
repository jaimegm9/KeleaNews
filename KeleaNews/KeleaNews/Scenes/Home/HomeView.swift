//
//  HomeView.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 29/1/24.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    @FocusState var isFocused: Bool
    @State private var scrollToTop: Bool = false
    private let searchBarId = "id"
    
    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    searchView()
                    LazyVStack {
                        switch vm.state {
                        case .loading:
                            loadingView()
                        case .loaded(let articles):
                            list(articles)
                        case .error(let error):
                            errorView(error)
                        }
                    }
                    .onChange(of: scrollToTop) { _ in
                        withAnimation {
                            proxy.scrollTo(searchBarId)
                        }
                    }
                }
            }
            searchButton()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                header()
            }
        }
        .onAppear {
            if vm.state == .loading {
                vm.loadingAndGetNews()
            }
        }
        .alert("NoNews", isPresented: $vm.noNews) {
            Button {
                vm.searchText = ""
            } label: {
                Text("ok")
            }
        }
    }
}

extension HomeView {
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Image("keleaLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            Spacer()
            Text("News")
                .foregroundStyle(Color.keleaOrange)
                .font(.title2)
        }
    }
    
    @ViewBuilder
    func searchView() -> some View {
        SearchBarView(searchText: $vm.searchText,
                      isFocused: _isFocused,
                      search: { vm.loadingAndGetNews() })
        .padding([.top, .bottom], 15)
        .id(searchBarId)
    }
    
    @ViewBuilder
    func list(_ articles: [Article]) -> some View {
        ForEach(articles) { article in
            CustomCellView(imageUrl: article.urlToImage,
                           title: article.title ?? "",
                           subtitle: article.author ?? "")
            .onAppear {
                vm.loadMoreArticlesIfNeeded(article: article)
            }
            .onNavigation {
                vm.openDetail(article)
            }
            .accessibility(identifier: Accessibility.Home.cell)
            if vm.isLastCell(article: article) && !vm.noMoreNews {
                LoadingCellView()
            }
        }
    }
    
    @ViewBuilder
    func searchButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    if isFocused {
                        vm.loadingAndGetNews()
                        isFocused.toggle()
                    } else {
                        isFocused.toggle()
                        scrollToTop.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Color.keleaOrange)
                        .clipShape(.circle)
                        .modifier(Shadow())
                }
                .padding([.bottom, .trailing], 20)
                .accessibility(identifier: Accessibility.Home.searchButton)
            }
        }
    }
    
    @ViewBuilder
    func errorView(_ error: String) -> some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .padding(.bottom, 20)
            Text(error)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)
        }
        .padding()
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            ForEach(0 ..< 2) { _ in
                LoadingCellView()
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView(vm: HomeViewModel(coordinator: Coordinator(),
                               getTopicNewsWorker: GetTopicNewsWorker(), 
                               getTopHeadlinesNewsWorker: GetTopHeadlinesWorker()))
}
