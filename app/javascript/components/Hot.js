import React from 'react';
import HotTable from 'react-handsontable';

class Hot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      minRows: 5,
      data: [[]],
      rowHeaders: false,
      colHeaders: false,
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

  handleChange = (event) => {
    const targetId = event.target.id;
    switch (targetId) {
      case 'row-headers':
        this.setState({
          rowHeaders: event.target.checked ? true : false
        });
        break;
      case 'column-headers':
        this.setState({
          colHeaders: event.target.checked ? this.colHeaders : false
        });
        break;
    }
  }
  <%- if @user %>
    <p>Welcome <%= @user.name %></p>
  <%- end %>
  <%= "Welcome #{@user.name}" %>
  "some string ${javascript.variable}"
  handleSubmit = () => {
    this.setState({settings: {data: [[]]}})
    // fetch('/new_event', {
    //   method: 'POST',
    //   data: this.state.data
    // }).then((reponse) => console.log(response));
    // this.setState({data: [[]]})
  }

  render() {
    return (
      <div id="hot-component">
        <div id="hot-options">
          <button onClick={this.addRows}>Add rows</button><br/>
          <label htmlFor="row-headers"><input onChange={this.handleChange} id="row-headers" type="checkbox" />Enable row headers</label><br/>
          <label htmlFor="column-headers"><input onChange={this.handleChange} id="column-headers" type="checkbox" />Enable column headers</label><br/>
        </div>
        <button onClick={this.handleSubmit}>Add Events</button>
        <div id="hot-preview">
          <HotTable root="hot" settings={this.state} minCols={this.minCols}/>
        </div>
      </div>
    );
  }
}

export default Hot
