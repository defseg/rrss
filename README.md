Reasonable RSS

TODO:
=====

* web interface to bucket/unbucket feeds
* bucket CRUD
* sidebar style should handle buckets better
* make the formatting not disappear
* switch servers to at least thin, preferably puma?
* it errors if there's whitespace before the http:// -- should trim that
* or if there's no http://
* add tags/buckets for feeds (none of liferea's folder nonsense)
* * this will mean feeds will need to have a show page so tags can be edited
* social: article sharing
* * separate follow page, or inject this into the RSS timeline?
* * shared articles become their own RSS feed?
* * * this would solve the separate/injected problem
* * * but at the cost of not letting users know who's following them
* * * if social, should add some method of communication maybe?
* * * no, no feature creep here
* * * even if user follows are handled internally, should still do RSS thing

DONE:
=====

* adding feeds from the page
* should have separate homepages for
* simple_rss fails on some pubDates (resolved, the test feed was broken...)
