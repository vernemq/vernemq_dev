%% @hidden
-module(on_unsubscribe_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_unsubscribe(UserName      :: username(),
                         SubscriberId  :: subscriber_id(),
                         Topics        :: [Topic :: topic()]) ->
    ok |
    {ok, unsub_modifiers()} |
    next.

-type unsub_modifiers() ::
        %% Change the topics which will be unsubscribed.
        [Topic :: topic()].

-export_type([unsub_modifiers/0]).
