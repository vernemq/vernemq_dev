%% @hidden
-module(auth_on_subscribe_m5_hook).
-include("vernemq_dev_int.hrl").

%% called as an all_till_ok - hook
-callback auth_on_subscribe_m5(UserName      :: username(),
                               SubscriberId  :: subscriber_id(),
                               Topics        :: [{Topic :: topic(), SubInfo :: subinfo()}],
                               Properties    :: sub_properties()) ->
    ok |
    {ok, sub_modifiers()} |
    {error, Reason :: any()} |
    next.

-type sub_properties() ::
        #{
          p_subscription_id => [subscription_id()],
          p_user_property => [user_property()]
         }.

-type sub_modifiers() ::
        #{
           topics => [{Topic :: topic(), SubInfo :: subinfo()}]
         }.

-export_type([sub_modifiers/0]).
