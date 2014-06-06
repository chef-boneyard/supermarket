Supermarket
===========

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
