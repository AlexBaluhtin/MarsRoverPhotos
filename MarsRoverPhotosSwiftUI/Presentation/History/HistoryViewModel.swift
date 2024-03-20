//
//  HistoryViewModel.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import CoreData
import Combine
import Foundation

protocol HistoryViewModelProtocol: ObservableObject {
  func selectFilter(filter: FilterDataModel)
  func deleteFilter()
  
  
  var filter: FilterModel { get set }
}

final class HistoryViewModel: HistoryViewModelProtocol {
  private var dataBaseService = CoreDataService.shared
  private var selectedFilter: FilterDataModel?
  
  @Published var filter: FilterModel = FilterModel(id: UUID())
  
  func selectFilter(filter: FilterDataModel) {
    self.selectedFilter = filter
    
    self.filter.id = filter.id ?? UUID()
    self.filter.rover = RoverName(rawValue: filter.rover ?? "") ?? .curiosity
    self.filter.camera = CameraIdentifier(rawValue: filter.camera ?? "") ?? .all
    self.filter.date = filter.date ?? Date()
  }
  
  func deleteFilter() {
    guard let filter = selectedFilter else { return }
    
    do {
      try filter.delete()
    } catch {
      print(error)
    }
  }
  
}
