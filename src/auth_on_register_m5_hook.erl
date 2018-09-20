%% @hidden
-module(auth_on_register_m5_hook).
-include("vernemq_dev.hrl").
-include("vernemq_dev_int.hrl").

%% called as an all_till_ok hook
-callback auth_on_register_m5(Peer          :: peer(),
                              SubscriberId  :: subscriber_id(),
                              UserName      :: username(),
                              Password      :: password(),
                              CleanStart    :: flag(),
                              Properties    :: reg_properties()) ->
    ok |
    {ok, reg_modifiers()} |
    {error, #{reason_code => err_reason_code_name()}} |
    {error, atom()} | %% will be turned into ?NOT_AUTHORIZED
    next.

-type reg_properties() ::
        #{
           ?P_SESSION_EXPIRY_INTERVAL_ASSOC,
           ?P_RECEIVE_MAX_ASSOC,
           ?P_TOPIC_ALIAS_MAX_ASSOC,
           ?P_MAX_PACKET_SIZE_ASSOC,
           ?P_REQUEST_RESPONSE_INFO_ASSOC,
           ?P_REQUEST_PROBLEM_INFO_ASSOC,
           ?P_USER_PROPERTY_ASSOC
         }.

-type reg_modifiers()   ::
        #{
           clean_start => flag(),
           max_message_size => non_neg_integer(),
           subscriber_id => subscriber_id(),
           shared_subscription_policy => sg_policy(),
           max_online_messages => non_neg_integer(),
           max_offline_messages => non_neg_integer()
         }.

-type err_reason_code_name() :: ?UNSPECIFIED_ERROR
                              | ?MALFORMED_PACKET
                              | ?PROTOCOL_ERROR
                              | ?IMPL_SPECIFIC_ERROR
                              | ?UNSUPPORTED_PROTOCOL_VERSION
                              | ?CLIENT_IDENTIFIER_NOT_VALID
                              | ?BAD_USERNAME_OR_PASSWORD
                              | ?NOT_AUTHORIZED
                              | ?SERVER_UNAVAILABLE
                              | ?SERVER_BUSY
                              | ?BANNED
                              | ?BAD_AUTHENTICATION_METHOD
                              | ?TOPIC_NAME_INVALID
                              | ?PACKET_TOO_LARGE
                              | ?QUOTA_EXCEEDED
                              | ?PAYLOAD_FORMAT_INVALID
                              | ?RETAIN_NOT_SUPPORTED
                              | ?QOS_NOT_SUPPORTED
                              | ?USE_ANOTHER_SERVER
                              | ?SERVER_MOVED
                              | ?CONNECTION_RATE_EXCEEDED.
