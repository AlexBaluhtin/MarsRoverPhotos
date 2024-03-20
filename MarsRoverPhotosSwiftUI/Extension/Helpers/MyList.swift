//
//  MyList.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import SwiftUI

struct MyList<Content: View>: View {
  let content: () -> Content
  
  var body: some View {
    if #available(iOS 14.0, *) {
      ScrollView {
        LazyVStack(spacing: 0) {
          self.content()
        }
      }
    } else {
      List {
        self.content()
          .listRowInsets(EdgeInsets())
      }
      .listStyle(GroupedListStyle())
      .introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .cyan
      }
    }
  }
}
//struct MyList<Content: View>: View {
//  @Binding var refreshing: Bool
//  
//  let content: () -> Content
//  
//  var body: some View {
//    if #available(iOS 14.0, *) {
////      RefreshableScrollView(refreshing: $refreshing) {
////        LazyVStack(spacing: 0) {
////          self.content()
////        }
////      }
//      ScrollView {
//        LazyVStack(spacing: 0) {
//          self.content()
//        }
//      }
//    } else {
//      List {
//        self.content()
//          .listRowInsets(EdgeInsets())
//      }
//      .listStyle(GroupedListStyle())
//      .introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
//        tableView.backgroundView = UIView()
//        tableView.backgroundColor = .cyan
//      }
//      .background(PullToRefresh(action: {}, isShowing: $refreshing))
//    }
//  }
//}
