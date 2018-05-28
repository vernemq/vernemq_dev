-module(on_deliver_m5_hook).
-include("vernemq_dev.hrl").
-type msg_modifier() ::
        #{
           topic => topic(),
           payload => payload(),
           properties => properties()
         }.

-callback on_deliver_m5(UserName      :: username(),
                        SubscriberId  :: subscriber_id(),
                        Topic         :: topic(),
                        Properties    :: properties(),
                        Payload       :: payload()) ->
    ok |
    {ok, Payload    :: payload()} |
    {ok, Modifiers  :: msg_modifier()} |
    next.

-export_type([msg_modifier/0]).
