//
//  SafariView.swift
//
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import SwiftUI
import SafariServices

public struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    public init(url: URL){
        self.url = url
    }
    
    public func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        return SFSafariViewController(url: url, configuration: configuration)
    }

    public func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}
