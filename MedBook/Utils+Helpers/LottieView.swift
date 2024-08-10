//
//  LottieView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var loopMode: LottieLoopMode = .loop
      var animationName: String

      func makeUIView(context: Context) -> UIView {
          let view = UIView(frame: .zero)
          let animationView = LottieAnimationView(name: animationName)
          animationView.contentMode = .scaleAspectFill
          animationView.loopMode = loopMode
          animationView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(animationView)

          NSLayoutConstraint.activate([
              animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
              animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
              animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])

          return view
      }

      func updateUIView(_ uiView: UIView, context: Context) {
          guard let animationView = uiView.subviews.compactMap({ $0 as? LottieAnimationView }).first else { return }
          animationView.play()
      }
}
