module.exports = (robot) ->
  robot.respond "/intuition/i", (res) ->
    res.http("https://api.hipchat.com/v2/room/1494222/history?auth_token=#{process.env.HIPCHAT_AUTH_TOKEN}")
      .get() (err, resp, body) ->
        try
          relevant_messages = []
          messages = JSON.parse(body)
          time = new Date()
          hour = time.getHours()
          for message in messages.items
            hour = parseInt(message.date.match(/T(..):/),1) 
            if ( 11 <= hour < 12)
               console.log message.message
        catch e
          res.send "Something went wrong!"
          console.log e
