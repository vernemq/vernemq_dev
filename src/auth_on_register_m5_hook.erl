-module(auth_on_register_m5_hook).
-include("vernemq_dev.hrl").


%% @doc Overwrite various values for this client. Properties are
%% passed to the
-type reg_modifiers()   ::
        #{
           mountpoint => mountpoint(),
           regview => reg_view(),
           clean_start => flag(),
           properties => properties()
         }.

%% @doc Reason code and properties to be passed back in the puback or
%% pubrec MQTT frames.
-type error_values() ::
        #{
           reason_code => reason_code_name(),
           properties => properties()
         }.

%% called as an all_till_ok hook
-callback auth_on_register_m5(Peer          :: peer(),
                              SubscriberId  :: subscriber_id(),
                              UserName      :: username(),
                              Password      :: password(),
                              CleanStart    :: flag(),
                              Properties    :: properties()) ->
    ok |
    {ok, reg_modifiers()} |
    {error, error_values()} |
    {error, atom()} | %% will be turned into ?NOT_AUTHORIZED
    next.

-export_type([reg_modifiers/0,
              error_values/0]).
