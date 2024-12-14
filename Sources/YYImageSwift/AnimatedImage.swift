//
//  SwiftUIView.swift
//  YYImage
//
//  Created by Mathijs Bernson on 02/12/2024.
//

import SwiftUI
import UIKit
import YYImage

/// View that plays an animated GIF
public struct AnimatedImage: UIViewRepresentable {
    let data: Data
    let contentMode: UIView.ContentMode
    @Environment(\.displayScale) var displayScale: CGFloat

    public init(data: Data, contentMode: UIView.ContentMode) {
        self.data = data
        self.contentMode = contentMode
    }

    public func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        return imageView
    }

    public func updateUIView(_ imageView: UIImageView, context: Context) {

        if let decoder = YYImageDecoder(data: data, scale: displayScale) {
            imageView.animationDuration = (0..<decoder.frameCount).map { index in
                decoder.frameDuration(at: index)
            }
            .reduce(0, +)

            imageView.animationImages = (0..<decoder.frameCount).compactMap { index in
                let frame = decoder.frame(at: index, decodeForDisplay: true)
                return frame?.image
            }
        }

        imageView.startAnimating()
    }
}

struct AnimatedImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImage(data: Data(), contentMode: .scaleAspectFit)
            .previewLayout(.fixed(width: 256, height: 256))
    }
}
