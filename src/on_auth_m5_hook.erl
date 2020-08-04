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
          p_authentication_method := utf8string(),
          p_authentication_data := binary()
         }.

-type auth_modifiers() ::
        #{
          %% Indicate towards the client if the authentication was
          %% successful or should be continued.
          reason_code => ?SUCCESS | ?CONTINUE_AUTHENTICATION,

          properties :=
                #{
                  %% Specify the authentication method to send to the client.
                  p_authentication_method := binary(),

                  %% Specify the authentication data to send to the client.
                  p_authentication_data := binary()
                 }
         }.

-type err_values() ::
        #{
           reason_code => reason_code_name()
         }.

-export_type([auth_properties/0, auth_modifiers/0, err_values/0]).
