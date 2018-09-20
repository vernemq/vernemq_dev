-module(on_deliver_m5_hook).
-include("vernemq_dev_int.hrl").

-callback on_deliver_m5(UserName      :: username(),
                        SubscriberId  :: subscriber_id(),
                        Topic         :: topic(),
                        Properties    :: deliver_properties(),
                        Payload       :: payload()) ->
    ok |
    {ok, Payload    :: payload()} |
    {ok, Modifiers  :: msg_modifier()} |
    next.

-type deliver_properties() ::
        #{
           ?P_PAYLOAD_FORMAT_INDICATOR_ASSOC,
           ?P_MESSAGE_EXPIRY_INTERVAL_ASSOC,
           ?P_TOPIC_ALIAS_ASSOC,
           ?P_RESPONSE_TOPIC_ASSOC,
           ?P_CORRELATION_DATA_ASSOC,
           ?P_USER_PROPERTY_ASSOC,
           ?P_SUBSCRIPTION_ID_ASSOC,
           ?P_CONTENT_TYPE_ASSOC
         }.

-type msg_modifier() ::
        #{
           topic => topic(),
           payload => payload()
         }.

-export_type([msg_modifier/0]).
