//
//  MainRowViewModel.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 18/03/2024.
//

import Combine
import SwiftUI

final class MainRowViewModel: ObservableObject {
  
  @Published var image: UIImage?
  
  private var cancellable: AnyCancellable?
  private var imageCache = ImageCache.getImageCache()
  
  init(urlString: String?) {
    loadImage(urlString: urlString)
  }
  
  private func loadImage(urlString: String?) {
    guard let urlString = urlString else { return }
    guard let url = URL(string: urlString) else { return }
    
    if let imageFromCache = imageCache[url] {
      image = imageFromCache
      return
    } else {
      loadImageFromUrl(urlString: urlString)
    }
  }
  
  private func loadImageFromUrl(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .handleEvents(receiveOutput: { [unowned self] image in
        guard let image = image else {return}
        self.imageCache[url] = image
      })
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }
  
}
