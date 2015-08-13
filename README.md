# teamcolony-rss [![Build Status](https://travis-ci.org/razorpay/teamcolony-rss.svg?branch=master)](https://travis-ci.org/razorpay/teamcolony-rss)

We use [TeamColony](http://teamcolony.com/) to help our team stay in sync.

Unfortunately, TeamColony doesn't have a way to notify you when someone
fills in the report for the day.

This simple sinatra based application converts the teamcolony JSON reports
to a simple RSS Feed that you can use wherever you want.

We have it integrated with our slack (via slack's RSS integration) so we get
notified whenever someone posts an update on teamcolony.

## Configuration

Since TeamColony's token based auth is currently broken, it uses the `_teamcolony_new_session`
cookie for authentication. Set the following environment variables in Heroku:

    COOKIE: Value of the _teamcolony_new_session cookie
    TEAM_NAME: Name of the team, as in teamcolony config

For development, it uses rake, minitest, webmock. You will also need an instance
of memcached running locally for development. It should fit within the `developer`
plan of Memcachier on heroku.

## Status

This is still a work-in-progress. (It can parse and read teamcolony responses),
but does not build the RSS feed as of yet.

# License

teamcolony-rss is released under the MIT License.

---

If you are interested in working on interesting things, maybe come work at [Razorpay](jobs@razorpay.com]).