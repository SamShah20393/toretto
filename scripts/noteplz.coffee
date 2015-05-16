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
    res.send "#(note.date)"