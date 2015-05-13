module.exports = (robot) ->
  robot.brain.set 'totalSodas', 15
  console.log "@@@@@@@@@@@@@@@@@@@@@@@@@"
  robot.hear /\?\?\?(.*)/i, (res) ->
    url = "https://api.hipchat.com/v2/room/1494222/history?&date=2015-05-12&timezone=Asia/Tokyo&auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
    console.log(url);
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "(areyoukiddingme) Got stuck here : #{err} "
          return
        try  
          data = JSON.parse(body)
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        console.log data
        room = res.message.id
        console.log room
        room = res.message.room
        console.log room
        room = res.message.user.id       
        console.log room
        room = res.message.user.name       
        console.log room


  robot.respond /have more soda/i, (res) ->
    # Get number of sodas had (coerced to a number).
    robot.brain.set 'totalSodas', 15
    sodasHad = robot.brain.get 'totalSodas'
    if sodasHad > 4
      res.reply "I'm too fizzy.."
    else
      res.reply 'Sure!'
    robot.brain.set 'totalSodas', sodasHad+1
    res.send "total #{sodasHad}"

  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    msg.reply 'zzzzz'
