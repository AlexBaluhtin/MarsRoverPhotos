//
//  UIImage+ImageCache.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 19/03/2024.
//

import UIKit

final class ImageCache {
  var cache = NSCache<NSURL, UIImage>()
  
  subscript(_ key: URL) -> UIImage? {
    get { cache.object(forKey: key as NSURL) }
    set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
  }
}

extension ImageCache {
  private static var imageCache = ImageCache()
  
  static func getImageCache() -> ImageCache {
    return imageCache
  }
}
