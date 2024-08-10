//
//  MCachedImage.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI
import CachedAsyncImage

struct MCachedImage: View {
    let url: String
    
    var body: some View {
        CachedAsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}
