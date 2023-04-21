## 1.3.1  - 21 April, 2023

* 🚀 [DEPRECATION FIX] File.exists? is changed to File.exist?, since File.exists? is deprecated in Ruby 3.x. [#11](https://github.com/freshworks/memoize_until/pull/11). Thanks to [@ruban-thilak](https://github.com/ruban-thilak).

## 1.2.1  - 08 May, 2020

* 🚀 [ENHANCEMENT] Public method `clear_now_for` added to `MemoizeUntil`, delegating the method to the underlying store object. This is done to support writing unit test cases without touching getting dirty with the private `Store` API. [#8](https://github.com/freshdesk/memoize_until/pull/8). Thanks to [@ritikesh](https://github.com/ritikesh).
