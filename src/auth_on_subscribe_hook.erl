%% @hidden
-module(auth_on_subscribe_hook).
-include("vernemq_dev.hrl").

%% called as an all_till_ok - hook
-callback auth_on_subscribe(UserName      :: username(),
                            SubscriberId  :: subscriber_id(),
                            Topics        :: [{Topic :: topic(), QoS :: qos()}]) ->
    ok |
    {ok, sub_modifiers()} |
    {error, Reason :: any()} |
    next.

-type sub_modifiers() ::
        %% Change the topics which will be subscribed.
        [{Topic :: topic(), Qos :: qos()}].

-export_type([sub_modifiers/0]).
