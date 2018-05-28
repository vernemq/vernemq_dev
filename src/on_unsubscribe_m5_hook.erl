-module(on_unsubscribe_m5_hook).
-include("vernemq_dev.hrl").

-type unsub_modifiers() ::
        #{
           topics => [topic()],
           properties => properties()
         }.

%% called as an 'all'-hook, return value is ignored
-callback on_unsubscribe_m5(UserName      :: username(),
                            SubscriberId  :: subscriber_id(),
                            Topics        :: [Topic :: topic()],
                            Properties    :: properties()) ->
    ok |
    {ok, unsub_modifiers()} |
    next.
