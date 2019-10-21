//
//  ViewService.swift
//  SwiftUIWebSocketMobile
//
//  Created by Alfian Losari on 20/10/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import SwiftUI

class ViewService: ObservableObject {
    
    @Published var homeView: HomeView? = nil
    private var service = SwiftUIViewService()
    private let jsonDecoder = JSONDecoder()
    
    func connect() {
        service.connect { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Error in receiving message: \(error)")
                case .success(let message):
                    switch message {
                    case .string(let text):
                        if let data = text.data(using: .utf8), let view = try? self.jsonDecoder.decode(HomeView.self, from: data) {
                            self.homeView = view
                        }
                        
                    default:
                        break
                    }
                }
            }
            
        }
    }
    
    
    
    
}
