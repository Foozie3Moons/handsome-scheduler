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
    this.colHeaders = ['Event Title', 'Description', 'All Day', 'Start Date', 'End Date', 'Start Time', 'End Time']
    this.columns = [
      {data: 'title'},
      {data: 'description'},
      {
        data: 'allDay',
        type: 'checkbox'
      },
      {
        data: 'startDate',
        type: 'date',
        dateFormat: 'MM/DD/YYYY',
        correctFormat: true,
        defaultDate: new Date()
      },
      {
        data: 'endDate',
        type: 'date',
        dateFormat: 'MM/DD/YYYY',
        correctFormat: true,
        defaultDate: new Date()
      },
      {
        data: 'startTime',
        type: 'time',
        timeFormat: 'h:mm:ss a',
        correctFormat: true
      },
      {
        data: 'endTime',
        type: 'time',
        timeFormat: 'h:mm:ss a',
        correctFormat: true
      }
    ]
    this.dataSchema = {
      title: null,
      description: null,
      allDay: false,
      startDate: null,
      endDate: null,
      startTime: null,
      endTime: null
    }
  }

  addRows = () => {
    this.setState({
      minRows: this.state.minRows + 1
    })
  }

  handleSubmit = () => {
    if ($('.htInvalid').length > 0) {
      alert('Please fix the highlighted cells', $('htInvalid'))
    } else {
      let data = this.state.data
      let token = $('meta[name="csrf-token"]').attr('content');
      for (let i = 0; i < data.length; i++) {
        let event = data[i];
        if (event.title && !event.allDay && event.startDate
          && event.startTime && event.endDate && event.endTime) {
          $.ajax({
            url: '/events/' + this.props.calendarId,
            type: 'POST',
            beforeSend: function(xhr) {
              // send CSRF token along with POST
              xhr.setRequestHeader('X-CSRF-Token', token)
            },
            data: {
              calendar_id: this.props.calendarId,
              title: event.title,
              description: event.description,
              start: moment(event.startDate + ' ' + event.startTime).format(),
              end: moment(event.endDate + ' ' + event.endTime).format()
            }
          }).then((response) => console.log(response))
        } else if (event.title && event.allDay) {
          $.ajax({
            url: '/events/' + this.props.calendarId,
            type: 'POST',
            beforeSend: function(xhr) {
              // send CSRF token along with POST
              xhr.setRequestHeader('X-CSRF-Token', token)
            },
            data: {
              calendar_id: this.props.calendarId,
              title: event.title,
              description: event.description,
              start: moment(event.startDate)
            }
          }).then((response) => console.log(response))
        }
      }
    }
  }

  render() {
    return (
      <div id="hot-component">
        <div className='hot-buttons'>
          <button className='button' onClick={this.addRows}>Add rows</button>&nbsp;&nbsp;
          <button className='button is-success' onClick={this.handleSubmit}>Add Events</button>
        </div>
        <div id="hot-preview">
          <HotTable root="hot"
            settings={this.state}
            minCols={this.minCols}
            rowHeaders={true}
            colHeaders={this.colHeaders}
            columns={this.columns}
            dataSchema={this.dataSchema}
          />
        </div>
      </div>
    );
  }
}

export default Hot
