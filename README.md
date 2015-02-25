Getting started
===============

riak_governor
-------------

**NOTE**: `~/rt/riak_governor/master` is an suggested path and can be substituted but needs to be adjusted in the .riak_test.config file

* clone riak_governer
* modify
        rel/vars/dev1.config
        rel/vars/dev2.config
        rel/vars/dev3.config
  + Change 'gov[123]@127.0.0.1' to  'dev[123]@127.0.0.1' respectively
* `make devrel` on riak_governor
* copy dev releases to a sandbox
```
mkdir master
cp -rf dev master/dev
cd master/dev
git init
git add dev
git rm -rf dev/dev[123]/data
git commit -m "initial"
```
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

