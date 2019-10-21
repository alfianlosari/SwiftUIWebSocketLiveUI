//
//  ContentView.swift
//  SwiftUIWebSocketMobile
//
//  Created by Alfian Losari on 20/10/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import SwiftUI
import StaggeredList
import Foundation


struct ContentView: View {
    
    @ObservedObject var service = ViewService()
    private let title = "WebSocket X SwiftUI"
    
    var body: some View {
        NavigationView {
            
            if service.homeView != nil {
                service.homeView!
                    .navigationBarTitle(title)
            }
            
            if service.homeView == nil {
                Text("Waiting for WebSocket SwiftUI View Data")
                    .navigationBarTitle(title)
            }
        }
            
            
        .onAppear {
            self.service.connect()
        }
    }
}

enum HomeLayout: String {
    case staggered
    case list
}

struct Item: Codable, Identifiable {
    
    var id: String
    var imageText: String
    var title: String
    var subtitle: String
    
    
    var image: UIImage {
        return UIImage(named: imageText) ?? UIImage(named: "image1")!
    }
    
    var imageAspectRatio: CGFloat {
        return image.size.width / image.size.height
    }
}



struct HomeView: View, Decodable {
    
    var layout = "list"
    var data: [Item] = []
    
    var _layout: HomeLayout {
        return HomeLayout(rawValue: self.layout) ?? .list
    }
    
    var numberOfOfColumns: Int {
        return _layout == .list ? 1 : 2
    }
    
    var body: some View {
       StaggeredLayoutList(data: self.data, numberOfColumns: numberOfOfColumns, horizontalSpacing: 8, verticalSpacing: 8, sectionInsets: .init(top: 0, leading: 8, bottom: 0, trailing: 8)) { ItemListView(item: $0) }

    }
    
}

struct ItemListView: View {
    
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: item.image)
            .resizable()
                .aspectRatio(item.imageAspectRatio, contentMode: .fit)
                .cornerRadius(8)
            Text(item.title)
                .font(.headline)
            Text(item.subtitle)
                .font(.subheadline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
