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
  
  robot.hear /take notes/i, (res) ->
    res.send "Sure, go ahead type in"