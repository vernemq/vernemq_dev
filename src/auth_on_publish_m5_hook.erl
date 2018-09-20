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
           ?P_PAYLOAD_FORMAT_INDICATOR_ASSOC,
           ?P_MESSAGE_EXPIRY_INTERVAL_ASSOC,
           ?P_CONTENT_TYPE_ASSOC,
           ?P_RESPONSE_TOPIC_ASSOC,
           ?P_CORRELATION_DATA_ASSOC,
           ?P_TOPIC_ALIAS_ASSOC,
           ?P_USER_PROPERTY_ASSOC
         }.

-type msg_modifier() ::
        #{
           topic => topic(),
           payload => payload(),
           reg_view => reg_view(),
           qos => qos(),
           retain => flag(),
           mountpoint => mountpoint()
         }.


-type error_values() ::
        #{
           reason_code => reason_code_name()
         }.


-export_type([msg_modifier/0]).
