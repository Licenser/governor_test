Getting started:

* clone riak_governer
* `make devrel` on riak_governor
* copy dev to `~/rt/riak_governor/master`
 * directory layout should be `~/rt/riak_governor/master/dev/dev{1,2,3}`
* Adjust the config files to the node names are dev{1,2,3}@127.0.0.1
* make sure the ~/.erlang.cookie matches
* `git init in ~/rt/riak_governor/master`
* `git commit -a -m "initial"`

riak_test
=========
* clone governor_test
* `make` (twice!)
* `cp governor_test.config ~/.riak_test.config` (or add the `riak_governor` section in the existing one)
* run: `./governor_test -v -t basic_command_line -c riak_governor`
* profit!

