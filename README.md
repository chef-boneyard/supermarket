# Supermarket

This cookbook deploys the [Supermarket application](https://github.com/opscode/supermarket).

## DEPRECATED

This cookbook is now deprecated and will no longer be maintained by Chef.  We recommend using a cookbook which installs Supermarket through the Supermarket omnibus package such as [supermarket-omnibus-cookbook](https://github.com/irvingpop/supermarket-omnibus-cookbook).

## About

This cookbook is split up into three different roles: Web, Redis, and Database. If you plan on running Supermarket
on a single node, just add the default recipe to the run_list.

By default with all three roles applied to a single node Supermarket relies on PostgreSQL peer authentication so there is no database password set. If you need to connect to a separate PostgreSQL database server, you may override Supermarket's database configuration within the app/supermarket.json data bag to configure a host, username and password.

If you need to connect to a separate Redis server, you may override Supermarket's Sidekiq configuration
within the app/supermarket.json data bag.

## Issues and Pull Requests

Issues for this cookbook should be opened on
[Supermarket GitHub Issues](https://github.com/opscode/supermarket/issues). Pull
requests can be opened on this repository, but it would be nice to have an
associated issue on the Supermarket repository.

In order to make managing Supermarket-related issues and features easier for
everybody, all issues are tracked on that repository.

# License and Authors

- Author: Brett Chalupa (<brett@gofullstack.com>)
- Author: Brian Cobb (<brian@gofullstack.com>)
- Author: Seth Vargo (<sethvargo@gmail.com>)
- Author: Tristan O'Neil (<tristanoneil@gmail.com>)
- Author: Joshua Timberman (<joshua@getchef.com>)
- Author: Gleb M Borisov (<borisov.gleb@gmail.com>)

- Copyright (C) 2014, Chef Software, Inc. (<legal@getchef.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
