//
//  MainViewModel.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import CoreData
import Combine
import Foundation
import SwiftUI

protocol MarsRoverPhotosViewModelProtocol: ObservableObject {
  func fetchPhotos()
  func saveSelectedImage(_ title: String)
  func getSelectedImage() -> String
  func changeStatusCalendar()
  func selectBottomSheetFilter(filter: TypeBottomSheetFilter)
  func getRowsToBottomSheet() -> [String]
  func saveFilter()
  func setRover(_ rover: RoverName)
  func setCamera(_ camera: CameraIdentifier)
  func setDate(_ date: Date)
  func changeFilter()
  
  var filter: FilterModel { get set }
}

final class MarsRoverPhotosViewModel: MarsRoverPhotosViewModelProtocol {
  private var dataBaseService = CoreDataService.shared
  
  @Published var filter: FilterModel = FilterModel(id: UUID()) {
      didSet {
        changeFilter()
      }
  }
  @Published var photos: [Photo] = []
  @Published var titleBottomSheet: LocalizedStringKey = ""
  @Published var isOpenCalendar = false
  
  var selectedImage: String = ""
  var selecterBottomSheetFilter: TypeBottomSheetFilter = .camera
  private let roversName: [RoverName] = [.curiosity, .opportunity, .spirit]
  private let marsRoverPhotosService: MarsRoverPhotosServiceProtocol
  private var cancellables = Set<AnyCancellable>()
  private var page = 0
  
  init(marsRoverPhotosService: MarsRoverPhotosServiceProtocol = MarsRoverPhotosNetworkService()) {
    self.marsRoverPhotosService = marsRoverPhotosService
  }
  
  public func onAppear() {
    page += 1
    self.fetchPhotos()
  }
  
  func changeFilter() {
    photos = []
    page = 0
    onAppear()
  }
  
  func fetchPhotos() {
    marsRoverPhotosService.getMarsPhotos(rover: filter.rover.rawValue,
                                         camera: filter.camera.rawValue,
                                         date: formatDate(filter.date),
                                         page: page)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] photos in
        self?.photos.append(contentsOf: photos.photos)
      }
      .store(in: &cancellables)
  }
  
  func saveSelectedImage(_ title: String) {
    self.selectedImage = title
  }
  
  func getSelectedImage() -> String {
    return self.selectedImage
  }
  
  func changeStatusCalendar() {
    isOpenCalendar.toggle()
  }
  
  func selectBottomSheetFilter(filter: TypeBottomSheetFilter) {
    self.selecterBottomSheetFilter = filter
  }
  
  func getRowsToBottomSheet() -> [String] {
    switch selecterBottomSheetFilter {
    case .rover:
      return roversName.map({ $0.rawValue })
    case .camera:
      return filter.rover.cameras.map({ $0.rawValue })
    }
  }
  
  func saveFilter() {
    let filter = FilterDataModel(context: dataBaseService.viewContext)
    filter.id = self.filter.id
    filter.rover = self.filter.rover.rawValue
    filter.camera = self.filter.camera.rawValue
    filter.date = self.filter.date
    filter.savedInDatabase = true
    
    dataBaseService.saveFilter(filter: filter)
  }
  
  func setRover(_ rover: RoverName) {
    self.filter.rover = rover
    self.changeFilter()
  }
  
  func setCamera(_ camera: CameraIdentifier) {
    self.filter.camera = camera
    self.changeFilter()
  }
  
  func setDate(_ date: Date) {
    self.filter.date = date
    self.changeFilter()
  }
}

extension MarsRoverPhotosViewModelProtocol {
  func formatDate(_ date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-M-d"
      return dateFormatter.string(from: date)
  }
}
