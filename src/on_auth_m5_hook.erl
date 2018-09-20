%% @hidden
-module(on_auth_m5_hook).
-include("vernemq_dev_int.hrl").

%% called as an all_till_ok hook
-callback on_auth_m5(UserName :: username(),
                     SubscriberId :: subscriber_id(),
                     Properties :: auth_properties()) ->
    {ok, auth_modifiers()} |
    {error, err_values()} |
    {error, any()} | %% does not send a reply to the client!
    next.

-type auth_properties() ::
        #{
           ?P_AUTHENTICATION_METHOD_ASSOC,
           ?P_AUTHENTICATION_DATA_ASSOC
         }.

-type auth_modifiers() ::
        #{
           %% Indicate towards the client if the authentication was
           %% successful or should be continued.
           reason_code => ?SUCCESS | ?CONTINUE_AUTHENTICATION,
           %% Specify the authentication method to send to the client.
           auth_method => binary(),
           %% Specify the authentication data to send to the client.
           auth_data => binary()
         }.

-type err_values() ::
        #{
           reason_code => reason_code_name()
         }.
