-module(auth_on_publish_m5_hook).
-include("vernemq_dev.hrl").
-type msg_modifier() ::
        #{
           topic => topic(),
           payload => payload(),
           reg_view => reg_view(),
           qos => qos(),
           retain => flag(),
           mountpoint => mountpoint(),
           properties => properties()
         }.


-type error_values() ::
        #{
           reason_code => reason_code_name(),
           properties => properties()
         }.

-callback auth_on_publish_m5(UserName      :: username(),
                             SubscriberId  :: subscriber_id(),
                             QoS           :: qos(),
                             Topic         :: topic(),
                             Payload       :: payload(),
                             IsRetain      :: flag(),
                             Properties    :: properties()) ->
    ok |
    {ok, Payload    :: payload()} |
    {ok, Modifiers  :: msg_modifier()} |
    {error, error_values()} |
    {error, Reason  :: atom()} | %% will be turned into ?NOT_AUTHORIZED
    next.

-export_type([msg_modifier/0]).
