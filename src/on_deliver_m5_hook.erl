%% @hidden
-module(on_deliver_m5_hook).
-include("vernemq_dev_int.hrl").

-callback on_deliver_m5(UserName      :: username(),
                        SubscriberId  :: subscriber_id(),
                        QoS           :: qos(),
                        Topic         :: topic(),
                        Payload       :: payload(),
                        IsRetain      :: flag(),
                        Properties    :: deliver_properties()) ->
    ok |
    {ok, Modifiers  :: msg_modifier()} |
    next.

-type deliver_properties() ::
        #{
          p_payload_format_indicator => unspecified | utf8,
          p_message_expiry_interval => seconds(),
          p_topic_alias => 1..65535,
          p_response_topic => topic(),
          p_correlation_data => binary(),
          p_user_property => nonempty_list(user_property()),
          p_subscription_id => [subscription_id()],
          p_content_type => utf8string()
         }.

-type msg_modifier() ::
        #{
          %% Rewrite the topic of the message.
          topic => topic(),

          %% Rewrite the payload of the message.
          payload => payload(),

          %% Rewrite the QoS of the message.
          qos => qos(),

          %% Rewrite the retain flag of the message.
          retain => flag(),

          properties =>
              #{
                %% Override the payload format indicator
                p_payload_format_indicator => unspecified | utf8,

                %% Override the content type
                p_content_type => utf8string(),

                %% Override the user properties from the properties or set
                %% them if not present.
                p_user_property => nonempty_list(user_property()),

                %% Override the response topic from the properties or set if
                %% not present.
                p_response_topic => topic(),

                %% Override the correlation data from the properties or set
                %% if not present.
                p_correlation_data => binary()
               }
         }.

-export_type([msg_modifier/0, deliver_properties/0]).
