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

-include("vernemq_dev.hrl").

-export([unword_topic/1,
         disconnect/0,
         disconnect/1,
         disconnect_by_subscriber_id/2]).



%% @doc Disconnect a client within a hook context.
%%
%% This function can only be used from within a plugin hook context.
-spec disconnect() -> ok.
disconnect() ->
    disconnect(self()).

%% @doc Disconnect a client by {@link pid()}.
%%
%% Given the session pid of a client, forcefully disconnect it.
-spec disconnect(SessionPid) -> ok when
      SessionPid :: pid().
disconnect(SessionPid) ->
    SessionPid ! disconnect,
    ok.

-type disconnect_flag() :: discard_state.

%% @doc Disconnect a client by {@link subscriber_id().}
%%
%% Given a subscriber_id the client is looked up in the cluster and
%% disconnected.
-spec disconnect_by_subscriber_id(SId, Opts) -> ok | not_found when
      SId  :: subscriber_id(),
      Opts :: [disconnect_flag()].
disconnect_by_subscriber_id({MP, ClientId}, Opts) ->
    QueryString = ["SELECT session_pid, queue_pid FROM sessions WHERE mountpoint=\"", MP,
                   "\" AND client_id=\"", ClientId, "\""],
    Results = vmq_ql_query_mgr:fold_query(fun(Row,Acc) -> [Row|Acc] end, [], QueryString),
    case Results of
        [] -> not_found;
        [#{queue_pid := _QPid,
           session_pid := SPid}] ->
            case discard_state(Opts) of
                true ->
                    %% TODO - discarding state doesn't work yet since:
                    %%
                    %% 1) vmq_queue:set_opts/2 currently does not
                    %% handle the `clean_session` flag.
                    %%
                    %% 2) vmq_queue:set_opts/2 hardwires the session
                    %% to self()...
                    disconnect(SPid);
                false ->
                    disconnect(SPid)
            end,
            ok
    end.

%% @private
discard_state(Opts) ->
    proplists:get_bool(discard_state, Opts).

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
