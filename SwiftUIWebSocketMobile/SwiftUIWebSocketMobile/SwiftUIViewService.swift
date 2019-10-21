//
//  ChatService.swift
//  SwiftUIWebSocketMobile
//
//  Created by Alfian Losari on 20/10/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

class SwiftUIViewService {
    
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    private let baseURL = URL(string: "ws://localhost:8080/ui")!
    
    func connect(onMessageReceived: @escaping (Result<URLSessionWebSocketTask.Message, Error>) -> Void) {
        stop()
        webSocketTask = urlSession.webSocketTask(with: baseURL)
        webSocketTask?.resume()
        
        sendPing()
        receiveMessage(completionHandler: onMessageReceived)
    }
    
    func stop() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    private func sendPing() {
        webSocketTask?.sendPing { (error) in
            if let error = error {
                print("Sending PING failed: \(error)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
                self?.sendPing()
            }
        }
    }
        
    private func receiveMessage(completionHandler: @escaping (Result<URLSessionWebSocketTask.Message, Error>) -> Void) {
        webSocketTask?.receive {[weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(_):
                completionHandler(result)
                self?.receiveMessage(completionHandler: completionHandler)
            }
        }
    }
    
}
