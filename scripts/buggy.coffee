module.exports = (robot) ->
  robot.respond "/intuition/i", (res) ->
    res.http("https://api.hipchat.com/v2/room/1494222/history?auth_token=#{process.env.HIPCHAT_AUTH_TOKEN}")
      .get() (err, resp, body) ->
        try
          relevant_messages = []
          messages = JSON.parse(body)
          time = new Date()
          current_hour = time.getHours()
          console.log current_hour - 1
          for message in messages.items
            hour = parseInt(message.date.match(/T(..):/)[1],10) 
            if ( (current_hour - 1) <= hour < current_hour)
              if message.message.match(/do|start|kill|create|prepare/)
                relevant_messages[hour].push(message.message)
                console.log message.message
        catch e
          res.send "Something went wrong!"
          console.log e
