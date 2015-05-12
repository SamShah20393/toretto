module.exports = (robot) ->

  robot.hear /\?\?(.*)/i, (res) ->
    url = "https://api.hipchat.com/v1/rooms/list?auth_token=cea75a927ad3dadb564884171c05e0"
    console.log(url);
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "Got stuck here : #{err} (areyoukiddingme)"
          return
        try  
          data = JSON.parse(body)
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        console.log data
