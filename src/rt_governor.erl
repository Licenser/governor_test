-module(rt_governor).

-export([
         get_leader/2,
         get_cluster_leader/1,
         is_leader/2,
         is_leader/3
         ]).


get_leader(Node, Key) ->
    rpc:call(Node, riak_governor, get_leader, [Key]).

get_cluster_leader(Node) ->
    rpc:call(Node, riak_governor, get_cluster_leader, []).

is_leader(Node, Key) ->
    rpc:call(Node, riak_governor, is_leader, [Key]).

is_leader(Node, ANode, Key) ->
    rpc:call(Node, riak_governor, is_leader, [ANode, Key]).
