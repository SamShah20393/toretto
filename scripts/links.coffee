# Description:
#   Remembers all the links and can retrieve at any time
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   torreto show me links
#   torreto clear all links
#
# Author
#   avellable

module.exports = (robot) ->
  
  robot.hear /(.*) (http[^\s]*)/i, (res) ->
    date = new Date
    robot.brain.data.links ||= []
    robot.brain.data.links.push {"link": res.match[2], "context": res.match[1], "time": date.getTime()}
  
  robot.respond /clear links/i, (res) ->
    robot.brain.data.links = []
    res.send "All links have been forgotten!"
    
  robot.respond /show me links/i, (res) ->
    res.send "#{link.link} something about: \"#{link.context}\"" for link in robot.brain.data.links
    #TODO: Add time of link mentioned in response
