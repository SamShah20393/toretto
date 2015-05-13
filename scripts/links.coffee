module.exports = (robot) ->
  
  robot.hear /(.*) (http[s?][^\s]*)/i, (res) ->
    robot.brain.data.links ||= []
    robot.brain.data.links.push {"link": res.match[2], "context": res.match[1]}
  
  robot.respond /clear links/i, (res) ->
    robot.brain.data.links = []
    res.send "All links have been forgotten!"
    
  robot.respond /show me links/i, (res) ->
    res.send link.link for link in robot.brain.data.links
