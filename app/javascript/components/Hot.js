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
    this.colHeaders = ['Event Title', 'Description', 'Start Date', 'End Date', 'Start Time', 'End Time']
    this.columns = [
      {},
      {},
      {
        type: 'date',
        dateFormat: 'MM/DD/YYYY',
        correctFormat: true,
        defaultDate: new Date()
      },
      {
        type: 'date',
        dateFormat: 'MM/DD/YYYY',
        correctFormat: true,
        defaultDate: new Date()
      },
      {
        type: 'time',
        timeFormat: 'h:mm:ss a',
        correctFormat: true
      },
      {
        type: 'time',
        timeFormat: 'h:mm:ss a',
        correctFormat: true
      }
    ]
  }

  addRows = () => {
    console.log(this.state)
    this.setState({
      minRows: this.state.minRows + 1
    })
    console.log(this.state)
  }

  handleSubmit = () => {
    console.log($('htInvalid'))
    if ($('.htInvalid').length > 0) {
      alert('Please fix the highlighted cells', $('htInvalid'))
    } else {
      let data = this.state.data
      let token = $('meta[name="csrf-token"]').attr('content');
      console.log(token);
      for (let i = 0; i < data.length; i++) {
        let event = data[i];
        if (event[0] !== null) {
          $.ajax({
            url: '/events/' + this.props.calendarId,
            type: 'POST',
            beforeSend: function(xhr) {
              // send CSRF token along with POST
              xhr.setRequestHeader('X-CSRF-Token', token)
            },
            data: {
              calendar_id: this.props.calendarId,
              title: event[0],
              description: event[1],
              start: moment(event[2] + ' ' + event[4]).format(),
              end: moment(event[3] + ' ' + event[5]).format()
            }
          })
            .then((response) => console.log(response))
            .then(() => this.setState({data: [[]]}));
        }
      }
    }
  }

  render() {
    return (
      <div id="hot-component">
        <div id="hot-options">
          <button onClick={this.addRows}>Add rows</button><br/>
        </div>
        <button onClick={this.handleSubmit}>Add Events</button>
        <div id="hot-preview">
          <HotTable root="hot" settings={this.state} minCols={this.minCols} rowHeaders={true} colHeaders={this.colHeaders} columns={this.columns}/>
        </div>
      </div>
    );
  }
}

export default Hot
