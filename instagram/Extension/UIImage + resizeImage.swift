//
//  UIImage + resizeImage.swift
//  instagram
//
//  Created by Edward O'Neill on 5/1/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
  static func resizeImage(originalImage: UIImage, rect: CGRect) -> UIImage {
    let rect = AVMakeRect(aspectRatio: originalImage.size, insideRect: rect)
    let size = CGSize(width: rect.width, height: rect.height)
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { (context) in
      originalImage.draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
