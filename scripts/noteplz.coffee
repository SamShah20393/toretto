# Description:
#   Take notes and minutes 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   torreto take notes
#   torreto show notes about <context>
#
# Author
#   Samkit


class Note
  constructor: (@title,@date,@total) ->

module.exports = (robot) ->
  
  noteMode = false 
  noteTitle = null

  robot.respond /take notes about (.*)/i, (res) ->
    title = res.match[1]
    noteTitle = title
    date = getDate new Date
    note = new Note title,date,0
    robot.brain.set title,note
    res.send "Sure, go ahead type in, saving for #{date}"

  robot.hear /(.*)/i, (res) ->
    if noteMode
      currentNote = robot.brain.get  noteTitle
      currentNote.total = currentNote.total + 1
      robot.brain.set noteTitle,currentNote
    else
      noteMode = true

  robot.hear /show notes about (.*)/i, (res) ->
    title = res.match[1]
    note = robot.brain.get title
    noteData = ""
    url = "https://api.hipchat.com/v2/room/Wergroot/history?date=#{note.date}&format=json&max-results=#{note.total}&auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
    console.log(url);
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "(areyoukiddqx1ingme) Got stuck here : #{err} "
          return
        try  
          data = JSON.parse(body)
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        console.log data

        for item in data.items
          noteData = noteData + item.message
        console.log "**********************"
        console.log noteData
    res.send "I found this #{noteData}"

  robot.respond /save this note/i, (res) ->
    if noteMode
      currentNote = robot.brain.get  noteTitle
      currentNote.total = currentNote.total + 1
      date = getDate new Date
      currentNote.date = date 
      robot.brain.set noteTitle,currentNote
      noteMode = false
      res.send "Okay sure done"
    else
      res.send "Sorry, i think you for to ask me to take notes (sadpanda)"
  
  getDate = (date) -> date.getFullYear() + '-' + (date.getMonth()+1) + '-'+ date.getDate() + 'T'+ date.getHours() + ':'+ date.getMinutes() + ':' + date.getSeconds()

  parseNoteData = (data) -> for item in data.items
                            item.message