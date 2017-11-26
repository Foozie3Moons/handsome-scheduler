# Handsome Scheduler

This project uses Rails, React, Handsontable, and Google's Calendar API to bulk add calendar events as opposed to simply one at a time.

The end goal of this application is to provide a baseline of event transfer to a Google Calendar (title, start date, end date) and have the rest post to a handsontable spreadsheet so that it can be quickly bulk edited/updated as needed. Users can have as many additional custom columns as they want to keep track of whatever data they might need.

This is a passion project of mine, arising out of the need for something like this in my previous position at American Councils. Coordinating hundreds of events in a year is challenging by itself. Excel is something that all professionals are familiar with, and having a tool to manage these events in a simple, yet familiar way is something that is desperately needed. It makes for easy transfer of existing data stored in spreadsheets as well, since all a user needs to do is format it locally in Excel and copy/paste in to the handsontable spreadsheet.


# Technologies Used
- Ruby
- Ruby on Rails
- React
- Webpacker
- Google OAuth
- Handsontable
- PostgreSQL
- Bulma

# Additional Features
- [ ] Undo all calendar additions of a specific post event (by using/storing some sort of post identifier when submitting events via the handsontable spreadsheet)
- [ ] Create new Google Calendars
- [ ] Allow for custom vestigial columns (for the user's purpose only, so that they can store data relevant to to the event but not necessarily relevant to a google calendar event)
- [ ] Toggle-able columns (all day events would remove start/end times, toggle description, etc.)
- [ ] Edit calendar events (using a handsontable spreadsheet) -- this would need to issue a get request to the google calendar api, compare the events to existing events to see if there is a change, and then if there is, send a put to update that event
- [ ] Tooltips and help documentation to make using the website easier
- [ ] Beautify landing page, decide on a color scheme (if any)
- [ ] Color code events

# Additional Infrastructure
- [ ] Model Event
  - associate to a handsontable post event (belongs_to :events_post_group)
  - associate to as many custom columns as exists (has_and_belongs_to_many :custom_columns)
- [ ] Model EventsPostGroup
  - associate to many events (has_many :events)
- [ ] Model CustomColumn
  - associate to many events (has_and_belongs_to_many :events)

# Optomizations
- [ ] Dry out Signet code
