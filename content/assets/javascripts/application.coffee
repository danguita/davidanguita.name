$ ->
  initialize = ->
    $("#twitter-json-wrapper").tweet
      username: "danguita"
      join_text: "-"
      avatar_size: false
      count: 8
      loading_text: false

    $("#delicious-json-wrapper").delicious "danguita",
      type: "posts"
      favicon: false

    $("#feed-wrapper").rssfeed "http://feeds.feedburner.com/DavidAnguita",
      limit: 3

  initialize()
