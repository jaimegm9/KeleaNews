//
//  CustomCellView.swift
//
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import SwiftUI

public struct CustomCellView: View {
    
    private enum ViewTraits {
        static let imageSize: CGFloat = 57
        static let cornerRadius: CGFloat = 10
        static let opacity: Double = 0.7
        static let margin: Double = 16
        static let marginBottom: Double = 20
        static let topMarginCaption: Double = 3
    }
    
    let imageUrl: String?
    let title: String
    let subtitle: String
    
    public init(imageUrl: String?, title: String, subtitle: String) {
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if let imageUrl {
                ImageCombine(placeholder: Image("placeholder"), url: URL(string: imageUrl))
            }
            
            VStack {
                if let imageUrl {
                    Spacer()
                }
                VStack(alignment: .leading)  {
                    Text(title)
                        .font(.body)
                        .foregroundStyle(.white)
                        .padding([.leading, .trailing, .top], ViewTraits.margin)
                    HStack {
                        Spacer()
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding([.bottom, .trailing], ViewTraits.margin)
                            .padding(.top, ViewTraits.topMarginCaption)
                    }
                }
                .background(Color.keleaDarkBlue.opacity((imageUrl != nil) ? 0.75 : 1))
            }
        }
        .cornerRadius(ViewTraits.cornerRadius)
        .padding([.leading, .trailing], ViewTraits.margin)
        .padding(.bottom, ViewTraits.marginBottom)
        .modifier(Shadow())
        
    }
}

struct CustomCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomCellView(imageUrl: "", title: "Lorem ipsum dolor sit amet consectetur adipiscing elit, facilisis nec ultrices augue sagittis mattis integer", subtitle: "www.nasa.com")
            .frame(width: 270,
                   height: 360)
            CustomCellView(imageUrl: nil, title: "Lorem ipsum dolor sit amet consectetur adipiscing elit", subtitle: "www.nasa.com")
            .frame(width: 270,
                   height: 160)
        }
        
    }
}
