//
//  ConstantsFonts.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 14/03/2024.
//

import SwiftUI

enum ConstantsFonts {
  case sfPro(CGFloat)
  case sfProBold(CGFloat)
  
  var font: Font {
    switch self {
    case .sfPro(let size):
      return .custom("SFProText-Regular", size: size)
    case .sfProBold(let size):
      return .custom("SFProText-Bold", size: size)
    }
  }
}
