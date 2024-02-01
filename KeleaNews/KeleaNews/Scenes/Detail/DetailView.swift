//
//  DetailView.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import SwiftUI
import DesignSystem

struct DetailView: View {
    
    private enum ViewTraits {
        static let padding: CGFloat = 16
    }
    
    @StateObject var vm: DetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    if let image = vm.article.urlToImage {
                        ImageCombine(placeholder: Image("placeholder"), url: URL(string: image))
                    }
                    VStack {
                        Text(vm.article.title ?? "")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding([.leading, .trailing, .top], ViewTraits.padding)
                        HStack {
                            Spacer()
                            Text(vm.article.author ?? "")
                                .foregroundStyle(.white)
                                .padding([.bottom, .trailing], ViewTraits.padding)
                                .padding(.top, 3)
                        }
                    }
                    .accessibility(identifier: Accessibility.Detail.title)
                    .background(Color.keleaDarkBlue)
                    
                    Text(vm.article.content ?? "")
                        .foregroundStyle(Color.keleaDarkBlue)
                        .background(.white)
                        .padding([.leading, .trailing, .top], ViewTraits.padding)
                        .accessibility(identifier: Accessibility.Detail.content)
                }
            }
            
            closeButton()
            safariButton()
        }
        .navigationBarHidden(true)
    }
}

extension DetailView {

    @ViewBuilder
    func closeButton() -> some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                        .padding()
                        .background(Color.keleaOrange)
                        .clipShape(.circle)
                        .modifier(Shadow())
                }
                .padding([.top, .leading], ViewTraits.padding)
                .accessibility(identifier: Accessibility.Detail.closeButton)
                Spacer()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func safariButton() -> some View {
        VStack {
            Spacer()
            Button(action: {
                vm.openSafari()
            }) {
                HStack {
                    Text("safari")
                    Image(systemName: "safari")
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.keleaOrange)
                .clipShape(.capsule)
                .modifier(Shadow())
            }
            .padding(.bottom, ViewTraits.padding)
            .accessibility(identifier: Accessibility.Detail.safariButton)
        }
    }
}

#Preview {
    DetailView(vm: DetailViewModel(coordinator: Coordinator(), article: Article(source: nil, author: nil, title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)))
}
