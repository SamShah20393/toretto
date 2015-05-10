module.exports = (robot) ->

  robot.hear /pull requests (.*)/i, (msg) ->
    repo_name = escape(msg.match[1])
    msg.http("https://api.github.com/repos/SamShah20393/#{repo_name}/pulls")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "Working .."
        catch error
          msg.send "No pull requests found on #{repo_name}"
