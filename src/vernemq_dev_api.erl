%% Copyright 2017 Erlio GmbH Basel Switzerland (http://erl.io)
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
-module(vernemq_dev_api).

-include_lib("vernemq_dev/include/vernemq_dev.hrl").

-export([unword_topic/1,
         disconnect_by_subscriber_id/2,
         has_session/1,
         reauthorize_subscriptions/3]).

-type disconnect_flag() :: do_cleanup.

%% @doc Disconnect a client by {@link subscriber_id().}
%%
%% Given a subscriber_id the client is looked up in the cluster and
%% disconnected.
-spec disconnect_by_subscriber_id(SId, Opts) -> ok | not_found when
      SId  :: subscriber_id(),
      Opts :: [disconnect_flag()].
disconnect_by_subscriber_id(SubscriberId, Opts) ->
    case vmq_queue_sup_sup:get_queue_pid(SubscriberId) of
        not_found ->
            not_found;
        QueuePid ->
            vmq_queue:force_disconnect(QueuePid, normal, proplists:get_bool(do_cleanup, Opts))
    end.

%% @doc Check if a {@link subscriber_id().} has an existing session
%%
%% Given a subscriber_id, this function checks if it has an existing
%% session.
-spec has_session(SId) -> true | false when
      SId  :: subscriber_id().
has_session(SubscriberId) ->
    case vmq_subscriber_db:read(SubscriberId) of
        undefined ->
            false;
        _Subs ->
            true
    end.

%% @doc Reauthorize subscriptions by username and subscriber_id
%%
%% Given a username and subscriber_id all subscriptions
%% of a matching client are reauthorized against the
%% currently installed `auth_on_subscribe` and
%% `auth_on_subscribe_m5` hooks.
-spec reauthorize_subscriptions(Username, SubscriberId, Opts) -> {vmq_subscriber:changes(), vmq_subscriber:changes()} when
      Username :: username(),
      SubscriberId :: subscriber_id(),
      Opts :: list().
reauthorize_subscriptions(Username, SubscriberId, _Opts) ->
    Subs0 = vmq_subscriber_db:read(SubscriberId, []),
    Subs1 =
    vmq_subscriber:fold(
      fun({Topic, SubInfo, Node}, AccSubs0) ->
              IsMQTT5 = is_tuple(SubInfo),
              HookRet =
              case IsMQTT5 of
                  true ->
                      vmq_plugin:all_till_ok(auth_on_subscribe_m5,
                                             [Username, SubscriberId, [{Topic, SubInfo}], #{}]);
                  false ->
                      vmq_plugin:all_till_ok(auth_on_subscribe,
                                             [Username, SubscriberId, [{Topic, SubInfo}]])
              end,
              case HookRet of
                  ok ->
                      AccSubs0;
                  {ok, Modifiers} when IsMQTT5 ->
                      NewTopics = maps:get(topics, Modifiers, []),
                      {AccSubs1, _} = vmq_subscriber:add(AccSubs0, NewTopics, Node),
                      AccSubs1;
                  {ok, NewTopics} ->
                      {AccSubs1, _} = vmq_subscriber:add(AccSubs0, NewTopics, Node),
                      AccSubs1;
                  {error, _Reason} ->
                      {AccSubs1, _} = vmq_subscriber:remove(AccSubs0, [Topic], Node),
                      AccSubs1
              end
      end, Subs0, Subs0),

    case Subs0 == Subs1 of
        true -> ok;
        false ->
            vmq_subscriber_db:store(SubscriberId, Subs1)
    end,
    vmq_subscriber:get_changes(Subs0, Subs1).

%% @doc Convert a {@link topic().} list into an {@link iolist().}
%% which can be flattened into a binary.
%%
%% Example:
%% ```
%%    1> iolist_to_binary(unword_topic([<<"a">>,<<"+">>,<<"b">>])).
%%    <<"a/+/b">>
%% '''
-spec unword_topic(Topic) -> iolist() when
      Topic :: topic().
unword_topic([Word|_] = Topic) when is_binary(Word) ->
    lists:reverse(unword_topic(Topic, []));
unword_topic(Topic) when is_binary(Topic) ->
    Topic;
unword_topic([]) -> [];
unword_topic(undefined) -> undefined;
unword_topic(empty) -> empty.

unword_topic([<<>>], []) -> [$/];
unword_topic([<<>>], Acc) -> Acc;
unword_topic([], Acc) -> [$/|Acc];
unword_topic([Word], Acc) -> [Word|Acc];
unword_topic([<<>>|Topic], Acc) ->
    unword_topic(Topic, [$/|Acc]);
unword_topic([Word|Rest], Acc) ->
    unword_topic(Rest, [$/, Word|Acc]).
