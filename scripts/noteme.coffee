# Description:
#   Can take notes, minutes of meetings and search
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
  
  robot.respond / please note about (.*)/i, (res) ->
    res.reply "Sure am taking down go ahead"