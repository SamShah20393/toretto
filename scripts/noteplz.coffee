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

  robot.respond /take notes about (.*)/i, (res) ->
    title = res.match[1] + res.message.room
    note = robot.brain.get title
    noteMode = robot.brain.get res.message.room + "noteMode"
    roomId = robot.brain.get res.message.room
    if noteMode
      res.send  "I am already taking notes of this chat (challengeaccepted) "
      return
    if note 
      res.send  "I already have this note , you can ask me again to take notes  a new name"
      return 
    date = getDate new Date
    note = new Note title,date,0
    robot.brain.set title,note
    robot.brain.set res.message.room + "noteMode",true
    robot.brain.set res.message.room + "noteTitle",title   
    if !roomId
      getRoomId res.message.room
    res.send "Sure, go ahead type in, saving for #{date}"

  robot.hear /(.*)/i, (res) ->
    noteMode = robot.brain.get res.message.room + "noteMode"
    noteTitle = robot.brain.get res.message.room + "noteTitle"
    if noteMode
      currentNote = robot.brain.get  noteTitle
      currentNote.total = currentNote.total + 1
      robot.brain.set noteTitle,currentNote
      

  robot.hear /show notes about (.*)/i, (res) ->
    title = res.match[1] + res.message.room
    note = robot.brain.get title
    roomId = robot.brain.get res.message.room
    if !roomId
      getRoomId res.message.room
      roomId = robot.brain.get res.message.room.toLowerCase
      res.send "I seem to have messed something up, hold on please and try again"
      return
    noteData = ""
    url = "https://api.hipchat.com/v2/room/#{roomId}/history?date=#{note.date}&format=json&max-results=#{note.total}&auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
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
        try 
          if res.statusCode isnt 200
            res.send "(philosoraptor) I dont think  I have such a note" 
            return
          for item in data.items
            noteData = noteData + item.message + "\n"
          res.send "this is what I found"
          res.send "#{noteData}"
        catch error
          res.send "Something went wrong" 
    
  robot.respond /save this note/i, (res) ->
    noteMode = robot.brain.get  res.message.room + "noteMode"
    noteTitle = robot.brain.get res.message.room + "noteTitle"
    if noteMode
      currentNote = robot.brain.get  noteTitle
      currentNote.total = currentNote.total - 2
      date = getDate new Date
      currentNote.date = date 
      robot.brain.set noteTitle,currentNote
      robot.brain.set res.message.room + "noteMode",false   
      res.send "Okay sure done"
    else
      res.send "Sorry, i think you for to ask me to take notes (sadpanda)"
  
  getDate = (date) -> date.getFullYear() + '-' + (date.getMonth()+1) + '-'+ date.getDate() + 'T'+ date.getHours() + ':'+ date.getMinutes() + ':' + date.getSeconds()

  parseNoteData = (data) -> for item in data.items
                            item.message

  getRoomId = (roomName) ->
    console.log "Starting Now"
    url = "https://api.hipchat.com//v2/room?auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          console.log "(areyoukiddqx1ingme) Got stuck here : #{err} "
          return
        try  
          data = JSON.parse(body)
        catch error
          console.log "That went over my head: #{err} (jackie)"
          return 
        for room in data.items
          robot.brain.set room.name.toLowerCase(),room.id
          console.log room.name.toLowerCase() + room.id