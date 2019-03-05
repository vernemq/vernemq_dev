%% @hidden
-module(on_deliver_m5_hook).
-include("vernemq_dev_int.hrl").

-callback on_deliver_m5(UserName      :: username(),
                        SubscriberId  :: subscriber_id(),
                        Topic         :: topic(),
                        Payload       :: payload(),
                        Properties    :: deliver_properties()) ->
    ok |
    {ok, Payload    :: payload()} |
    {ok, Modifiers  :: msg_modifier()} |
    next.

-type deliver_properties() ::
        #{
          p_payload_format_indicator => unspecified | utf8,
          p_message_expiry_interval => seconds(),
          p_topic_alias => 1..65535,
          p_response_topic => topic(),
          p_correlation_data => binary(),
          p_user_property => [user_property()],
          p_subscription_id => [subscription_id()],
          p_content_type => utf8string()
         }.

-type msg_modifier() ::
        #{
          %% Rewrite the topic of the message.
          topic => topic(),

          %% Rewrite the payload of the message.
          payload => payload()
         }.

-export_type([msg_modifier/0]).
