import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(){
    super()
    this.state = {
      shift: 3,
      input: "hello",
      output: ""
    }

    this.inputChange = this.inputChange.bind(this)
    this.outputChange = this.outputChange.bind(this)
    this.shiftChange = this.shiftChange.bind(this)
  }

  runCipher(){

  }

  inputChange(e){
    this.setState({
      input: e.target.value
    })
  }

  outputChange(e){
    this.setState({
      output: e.target.value
    })
  }

  shiftChange(e){
    this.setState({
      shift: e.target.value
    })
  }

  componentWillUpdate(nextProps, nextState) {
    console.log(nextState)
  }

  render() {
    return (
      <div className="App">
        <div>
          <label>Shift:</label>
          <input type="number" cols="3" value={this.state.shift} onChange={this.shiftChange}/>
        </div>
        <div>
          <label>Input:</label>
          <input type="text" cols="5" value={this.state.input} onChange={this.inputChange}/>
        </div>
        <div>
          <label>Output:</label>
          <input type="text" cols="5" value={this.state.output} onChange={this.outputChange}/>
        </div>
        <button onClick={this.runCipher}>Encipher/Decipher</button>
      </div>
    );
  }
}

export default App;
