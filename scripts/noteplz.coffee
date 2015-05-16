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
#   avellable

module.exports = (robot) ->
  
  robot.hear / take notes /i, (res) ->
    res.send "Sure, go ahead type in"
  
  robot.respond /clear links/i, (res) ->
    robot.brain.data.links = []
    res.send "All links have been forgotten!"
    
  robot.respond /show me links/i, (res) ->
    res.send "#{link.link} something about: \"#{link.context}\"" for link in robot.brain.data.links
    #TODO: Add time of link mentioned in response
