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
         disconnect_by_subscriber_id/2]).

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
