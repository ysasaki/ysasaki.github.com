ClojureとPerlのライブラリ比較
=============================

Sapporo.clj#0  
@aloelight

Web
----

 * ring
   * Plack
 * ring.middleware.*
   * Plack::Middleware::*
 * ring.adapter.*
   * Plack::Handler::*
 * compojure
   * Plack::Request + Router::Boom

Web Server
----------

 * ring.adapter.jetty
   * Starman
   * Starlet
 * http-kit
   * Twiggy

Web Application Framework
-------------------------

 * moustache
   * Amon2::Lite
   * Mojolicious::Lite
 * luminus
   * Amon2
   * Mojolicious

Log
---

 * tools.logging
   * Log::Minimal
 * timbre
   * Log::Minimal
   * Devel::NYTProf

HTML
----

 * enlive
   * Web::Scraper
 * hiccup
   * Text::Haml
 * selmer
   * Text::Xslate

Validation
----------

 * bouncer
   * Data::Validator

DB
---

 * java.jdbc
   * DBI, DBD
 * korma
   * Teng
   * DBIx::Class

Cache
-----

 * spyglass
   * Cache::Memcached::Fast
   * Cache::Memcached::libmemcahced
 * carmine
   * Redis
   * Redis::Fast

HTTP
----

 * http.agent
 * clj-http
   * LWP + HTTP::Request::Common
 * http-kit
   * AnyEvent::HTTP

Async
-----

 * core.async
   * AnyEvent
   * Coro

JSON
----

 * clj-json
   * JSON

XML
----

 * data.xml
   * XML::*

Date
----

  * clj-time
    * DateTime
    * Time::Piece

Test
----

 * clojure.test
   * Test::More
 * Midje
   * Test::Spec

おわり
------
