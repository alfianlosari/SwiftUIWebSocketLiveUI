import Foundation

import KituraNet
import KituraWebSocket

import HeliumLogger
import LoggerAPI

// Using an implementation for a Logger
HeliumLogger.use(.info)

WebSocket.register(service: ChatService(), onPath: "ui")

class ChatServerDelegate: ServerDelegate {
    public func handle(request: ServerRequest, response: ServerResponse) {}
}

// Add HTTP Server to listen on port 8080
let server = HTTP.createServer()
server.delegate = ChatServerDelegate()

do {
    try server.listen(on: 8080)
    print("Kitura WebSocket listening on port 8080")
    ListenerGroup.waitForListeners()
} catch {
    Log.error("Error listening on port 8080: \(error).")
}
