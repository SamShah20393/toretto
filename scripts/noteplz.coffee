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
#   torreto clear all links
#
# Author
#   Samkit

class Note
  constructor: (@title,@date) ->

module.exports = (robot) ->
  
  robot.hear /take notes about (.*)/i, (res) ->
    title = res.match[1]
    date = new Date
    note = new Note title,date
    robot.brain.set title,note
    res.send "Sure, go ahead type in"

  robot.hear /show notes about (.*)/i, (res) ->
    title = res.match[1]
    note = robot.brain.get title
    url = "https://api.hipchat.com/v2/room/Wergroot/history?&date=#{note.date}&timezone=Asia/Tokyo&format=json&auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
    console.log(url);
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "(areyoukiddingme) Got stuck here : #{err} "
          return
        try  
          data = JSON.parse(body)
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        console.log data
    res.send "#{note.date}"