import React, { Component } from 'react';
import ReactJson from 'react-json-view'
import client from './webSocketClient';
import stubJSON from './stub';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  json = stubJSON;

  update = (updatedObject) => {    
    this.json = updatedObject.updated_src;
    
  }

  sendClicked = (e) => {
    if (client.readyState === client.OPEN) {
      const jsonString = JSON.stringify(this.json);
      client.send(jsonString);
      console.log(`Sent: ${jsonString}`);
    }    
  }

  render() {
      return (
        <div className="App">
          <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            <h1>
              React WebSocket SwiftUI Client
            </h1>
            <h3>Edit JSON to send and decoded to SwiftUI View in iOS App</h3>
           
          </header>
          <main>
            <div className="action">
              <button onClick={this.sendClicked}>Send to WebSocket Server</button>
            </div>
            <ReactJson
             theme={"monokai"}
             iconStyle={"triangle"}
             indentWidth={4}
             collapsed={false}
             onAdd={this.update}
             onEdit={this.update}
             onDelete={this.update}
             enableClipboard={true}
             src={this.json} />
          </main>
        </div>
      ); 
  }
}




export default App;
