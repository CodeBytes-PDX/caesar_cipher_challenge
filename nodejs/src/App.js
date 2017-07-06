import React, { Component } from 'react';
import './App.css';

class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      shift: 2,
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
    if(e.target.value){
      this.setState({
        input: e.target.value,
        output: e.target.value.trim().split('').map(v =>
          this.getShift(v)).join('')
      })
    }
    else{
      this.setState({
        input: "",
        output: ""
      })
    }
  }

  getShift(char){
    let charCode = char.toLowerCase().charCodeAt(0)
    charCode += parseInt(this.state.shift,10)
    if(charCode > 122){
      charCode -= 25
    }

    return String.fromCharCode(charCode)
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
    if(e.target.value){
      if(this.state.input){
        this.setState({
          input: this.state.input,
          output: this.state.input.trim().split('').map(v =>
            this.getShift(v)).join('')
        })
      }
      else{
        this.setState({
          input: "",
          output: ""
        })
      }
    }
  }

  render() {
    return (
      <div className="App">
        <div>
          <label>Shift:</label>
          <input type="number" rows="3" value={this.state.shift} onChange={this.shiftChange}/>
        </div>
        <div>
          <label>Input:</label>
          <input type="text" rows="5" value={this.state.input} onChange={this.inputChange}/>
        </div>
        <div>
          <label>Output:</label>
          <input type="text" rows="5" value={this.state.output} onChange={this.outputChange}/>
        </div>
      </div>
    );
  }
}

export default App;
