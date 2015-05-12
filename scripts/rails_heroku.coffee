{spawn} = require 'child_process'

module.exports = (robot) ->

  robot.hear /ls/i, (res) ->
    ls = spawn 'ls'
    # receive all output and process
    ls.stdout.on 'data', (data) -> console.log data.toString().trim()
    res.send data
    # receive error messages and process
    ls.stderr.on 'data', (data) -> console.log data.toString().trim()
