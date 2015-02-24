Getting started
===============

riak_governor
-------------

**NOTE**: `~/rt/riak_governor/master` is an suggested path and can be substituted but needs to be adjusted in the .riak_test.config file

* clone riak_governer
* `make devrel` on riak_governor
* copy dev to `~/rt/riak_governor/master`
 * directory layout should be `~/rt/riak_governor/master/dev/dev{1,2,3}`
 * **NOTE**: copying is **not** optional! raik_test will perform git opperations on the directory so pointing it to the `dev` inside your original repo is a **very bad idea**!

* Adjust the config files to the node names are dev{1,2,3}@127.0.0.1
 * **NOTE**: This node names are not optional they can't be configure in riak_test
* make sure the ~/.erlang.cookie matches
* `git init in ~/rt/riak_governor/master`
* `git commit -a -m "initial"`

riak_test
---------

* clone governor_test
* `make` (twice!)
* `cp governor_test.config ~/.riak_test.config` (or add the `riak_governor` section in the existing one)
* run: `./governor_test -v -t basic_command_line -c riak_governor`
* profit!

