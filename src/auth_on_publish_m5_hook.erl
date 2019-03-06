%% @hidden
-module(auth_on_publish_m5_hook).
-include("vernemq_dev_int.hrl").
-callback auth_on_publish_m5(UserName      :: username(),
                             SubscriberId  :: subscriber_id(),
                             QoS           :: qos(),
                             Topic         :: topic(),
                             Payload       :: payload(),
                             IsRetain      :: flag(),
                             Properties    :: pub_properties()) ->
    ok |
    {ok, Payload    :: payload()} |
    {ok, Modifiers  :: msg_modifier()} |
    {error, error_values()} |
    {error, Reason  :: atom()} | %% will be turned into ?NOT_AUTHORIZED
    next.

-type pub_properties() ::
        #{
          p_payload_format_indicator => unspecified | utf8,
          p_message_expiry_interval => seconds(),
          p_content_type => utf8string(),
          p_response_topic => topic(),
          p_correlation_data => binary(),
          p_topic_alias => 1..65535,
          p_user_property => [user_property()]
         }.

-type msg_modifier() ::
        #{
          %% Change the topic of the message
          topic => topic(),

          %% Change the payload of the message.
          payload => payload(),

          %% Change the QoS of the message.
          qos => qos(),

          %% Change the retain flag of the message.
          retain => flag(),

          %% Change the mountpoint where the message is
          %% published.
          mountpoint => mountpoint(),

          %% Throttle the publisher for a number of
          %% milliseconds. Note, there is no
          %% back-pressure for websocket connections.
          throttle => milliseconds(),

          properties =>
              #{
                %% Override the message expiry from the properties or set it
                %% if not present.
                p_message_expiry_interval => seconds(),

                %% Override the user properties from the properties or set
                %% them if not present.
                p_user_property => [user_property()],

                %% Override the response topic from the properties or set if
                %% not present.
                p_response_topic => topic(),

                %% Override the correlation data from the properties or set
                %% if not present.
                p_correlation_data => binary()
               }
         }.


-type error_values() ::
        #{
           reason_code => reason_code_name()
         }.

-export_type([msg_modifier/0]).
