//
//  ImageCombine.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import SwiftUI
import Combine

public enum NetworkError: Error {
    case generic
}

public struct ImageCombine: View {
    let placeholder: Image?
    let url: URL?
    
    @State private var image: Image? = nil
    @State private var subscribers = Set<AnyCancellable>()
    
    public init(placeholder: Image?, url: URL?, image: Image? = nil, subscribers: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.placeholder = placeholder
        self.url = url
        self.image = image
        self.subscribers = subscribers
    }
    
    public var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
            }
        }
        .onAppear(perform: getImage)
    }
}
    
public extension ImageCombine {
    func getImage() {
        guard let url else {
            return
        }
        if let imageFromCache = Cache.image.object(forKey: url.absoluteString as NSString) {
            image = Image(uiImage: imageFromCache)
        } else {
            URLSession.shared
                .dataTaskPublisher(for: url)
                .compactMap {
                    if let uiimage = UIImage(data: $0.data) {
                        Cache.image.setObject(uiimage, forKey: url.absoluteString as NSString)
                    }
                    return UIImage(data: $0.data).map(Image.init)
                }
                .catch { _ in
                    Empty()
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
                .assign(to: \.image, on: self)
                .store(in: &subscribers)
        }
    }
}
