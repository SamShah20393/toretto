module.exports = (robot) ->
  
  robot.hear /(.*) http(.*)?\w/i, (res) ->
    robot.brain.data.links ||= []
    robot.brain.data.links.push {"link": "http#{res.match[2]}", "context": res.match[1]}
  
  robot.hear /(.*) https(.*)?\w/i, (res) ->
    robot.brain.data.links ||= []
    robot.brain.data.links.push {"link": "https#{res.match[2]}", "context": res.match[1]}
    
  robot.respond /show me links/i, (res) ->
    res.send link.link for link in robot.brain.data.links
