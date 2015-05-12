module.exports = (robot) ->

  robot.hear /?(.*)/i, (res) ->
    res.send "who Me??"
