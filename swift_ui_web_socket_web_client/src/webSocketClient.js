import { w3cwebsocket as W3CWebSocket } from "websocket";


const client = new W3CWebSocket('ws://localhost:8080/ui');

client.onopen = () => {
    console.log('WebSocket Client Connected');
};

export default client;
