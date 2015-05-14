# Description:
#  Sends random hipchat emoticon in response heard emoticon
#
# Dependencies:
#   None
#
# Command:
#   Send an emoticon in conversation
#
# Author:
#   Samkit

module.exports = (robot)  ->

  robot.hear /\([A-Z]+\)/i, (res) ->
    res.http("https://api.hipchat.com/v2/emoticon?auth_token=#{process.env.HIPCHAT_AUTH_TOKEN}")
      .get() (err, resp, body) ->
      	try
      	  emoticons = JSON.parse(body)
      	  a = Math.random
      	  b = emoticons.length
      	  console.log a
      	  console.log b
      	  console.log Math.floor(a * b)
      	  res.send "(#{emoticons[Math.floor(Math.random() * emoticons.length)].shortcut})"
      	catch err
      	  res.send "Something went wrong!"
      	  console.log err
