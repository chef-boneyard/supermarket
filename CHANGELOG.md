v3.3.1 (2015-09-04)
-------------------
- Cookbook deprecated in favor of [supermarket-omnnibus-cookbook](https://github.com/irvingpop/supermarket-omnibus-cookbook)

v3.3.0 (2015-05-18)
-------------------
- [#96] Use the chef\_vault\_item helper
- [#95] Use CentOS 6.6 in Test Kitchen

v3.2.1 (2015-04-22)
-------------------
- [#94] Remove references to \_git recipe
- [#93] Use correct user in PostgreSQL recipe guards
- [#92] Fix double quotes in required attributes error message
- [#91] Enable pgdg Apt repo; remove duplicate kitchen attributes

v3.2.0 (2015-04-17)
-------------------
- [#90] Fix compatibility with RHEL/CentOS 6
- [#89] Fix psql commands in PostgreSQL recipe
- [#87] Use the correct `X-Forwarded-Proto` headers in Nginx
- [#86] Fix PostgreSQL attribute names
- [#85] Include postgresql-contrib package including pg\_tgrm
- [#84] Use correct exit codes for `psql` commands
- [#83] Use HTTPS URLs in Berksfile for firewall friendliness

v3.1.0 (2014-12-17)
-------------------
- [#82] Add a supermarket_instance resource

v3.0.0 (2014-11-21)
--------------------
- [#79] Correct references to ssl cert and key path
- [#80] Update specs
- [#76] Add new URL variables
- [#81] Add privacy flag

v2.15.0 (2014-11-06)
--------------------
- [#75] Lint and cleanup
- [#72] Travis CI integration
- [#78] Fixing missing references to deleted recipes

v2.14.4 (2014-10-30)
--------------------
- [#74] Decouple Ruby recipe from application deployment

v2.14.2 (2014-10-28)
--------------------
- [#73] Move to redisio cookbook for redis

v2.14.1 (2014-10-27)
--------------------
- [#71] Fixes Specs and Redis Config

v2.14.0 (2014-10-21)
--------------------
- [#62] Add RHEL/CentOS Support
- [#66] Add Configurable URLS
- [#68] Update Ruby to 2.1.3
- [#54] Add CHEF_OAUTH2_VERIFY_SSL flag

v2.13.0 (2014-10-15)
-------------------
- [#65] Remove Segment.io

v2.12.0 (2014-10-09)
-------------------
- [#55] StatsD environment variables
- [#56] CLA Report Email environment variable
- [#63] Upgrade to Ruby 2.1.3

v2.11.0 (2014-09-15)
-------------------
- [#59] Run unicorn as the supermarket user, not root

v2.10.0 (2014-09-05)
-------------------
- [#49] Graceful restarts with runit and unicorn
- [#57] Setting the max body size in nginx to 250m
- [#58] Update bundler to 1.7.2

v2.9.0 (2014-08-28)
-------------------
- [#51] Add chef-vault support for the application data bag

v2.8.0 (2014-08-25)
-------------------
- [#52] Add fieri configuration elements to ENV

v2.7.2 (2014-08-12)
-------------------
- [#50] Fix broken symlink of .env.production

v2.7.1 (2014-08-07)
-------------------
- [#48] Fix missing end statement

v2.7.0 (2014-08-07)
-------------------
- [#44] Add unicorn configuration
- [#45] Allow CDN URL to be configured in apps databag
- [#47] Combine ENV feature flag variables into a single ENV variable
- [#46] Template missing in v2.6.0 on community site download is fixed

v2.6.0 (2014-08-06)
-------------------
- [#42] Make the application repository configurable through the data bag
- [#43] Make the OAUTH2 URL configurable through the data bag

v2.5.0 (2014-07-23)
-------------------

- Support ENV based app feature flags
- As a default, calculate the number of unicorn workers by # of CPUs

v2.4.3 (2014-07-07)
-------------------

The "supermarket is live" release!

- Remove `COMMUNITY_SITE_DATABASE_URL` from .env
- Make use of `WEB_CONCURRENCY` for unicorn config to allow adjusting
  the number of workers based on the number of CPUs.
- Add an attribute to allow certain domains to not be redirected from
  http -> https.

v2.4.2 (2014-07-07)
-------------------

- **IMPORTANT** Version 2.4.2 was tagged incorrectly.

v2.4.1 (2014-07-03)
-------------------

- Add log rotation to avoid filling disk with rails and nginx logs


v2.3.6 (2014-07-02)
-------------------

- No new code. Recovering from error.


v2.3.5 (2014-07-02)
-------------------

- Add Curry Success label to .env.production template


v2.3.3 (2014-07-02)
-------------------

- Allow Google Analytics ID to be configured (#27)
- Add CCLA and ICLA versions to the .env.production template (#30)


v2.3.1 (2014-06-30)
-------------------

- Corrects supermarket::vagrant recipe missing _mysql


v2.3.0 (2014-06-25)
-------------------

- Moves bundler vendored gems to a shared directory that does not get recreated during each deploy (#25)
- Adds sv log to runit service (#26)


v2.2.2 (2014-06-24)
-------------------

- Add a .gemrc for the supermarket user (#23)
- Add Segment.IO key to .env.production template


v2.2.0 (2014-06-23)
-------------------

* Allow protocol to be configured for things like email, etc. (#21)
* Install libarchive-dev (#20)
* Fix the order of mysql recipe (#17)


v2.1.2 (2014-06-18)
-------------------

* In 2.1.0, the force_ssl attribute was added. During development it
  was previously enforce_ssl, but the template wasn't updated.


v2.1.0 (2014-06-18)
-------------------

* Support enforcing HTTPS redirect


v2.0.2 (2014-06-11)
-------------------

* Adds libmysql to make it so bundler completes


v2.0.0 (2014-06-10)
-------------------

This release may not work properly if you currently define an empty database key in your apps data bag. Please remove it, if it is uneeded.

* Adds support for serving sitemaps via nginx
* Adds support for generating sitemaps after a deploy
* Refines the way database.yml is handled
* Allows COMMUNITY_SITE_DATABASE_URL to be set via the databag for imports from the old community site to be run.
* Updates .kitchen.cloud.yml to test 14.04


v1.3.4 (2014-06-06)
-------------------

- Move postgres dev header package install to ruby recipe (required to build `pg` gem)
- Ensure build-essential is installed so bundle can build gems' C extensions
- Add port option to database.yml


v1.3.2 (2014-06-06)
-------------------

- Test on Ubuntu 14.04
- Create postgresql config directory
- Use link resources for ruby instead of update-alternatives


v1.3.0 (2014-06-02)
-------------------

- Updates testing harness
- Adds `supermarket::web` recipe for deploying web servers
- Adds `node['supermarket']['data_bag']` as an easy way to use a different data bag in prod.


v1.2.6 (2014-05-30)
-------------------

Actual push to the community site


v1.2.5 (2014-05-30)
-------------------

This is the initial version of the cookbook published to the community site.
