import React from 'react';
import HotTable from 'react-handsontable';

class Hot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      minRows: 5,
      data: [[]],
    }
    this.minCols = 4
    this.colHeaders = ['Event Title', 'Start Date', 'End Date', 'Description']
  }

  addRows = () => {
    console.log(this.state)
    this.setState({
      minRows: this.state.minRows + 1
    })
    console.log(this.state)
  }

  handleChange = (e) => {
    console.log('something happened')
    let data = hot.getData()
    this.setState({
      data: data
    });
    console.log(data);
  }

  handleSubmit = () => {
    console.log(this.state);
    fetch('/events/' + props.calendarId, {
      method: 'POST',
      data: this.state.data
    })
      .then((reponse) => console.log(response))
      .then(() => this.setState({data: [[]]}));
  }

  render() {
    return (
      <div id="hot-component">
        <div id="hot-options">
          <button onClick={this.addRows}>Add rows</button><br/>
        </div>
        <button onClick={this.handleSubmit}>Add Events</button>
        <div id="hot-preview">
          <HotTable root="hot" settings={this.state} minCols={this.minCols} rowHeaders={true} colHeaders={this.colHeaders}/>
        </div>
      </div>
    );
  }
}

export default Hot
