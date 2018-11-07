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
          p_session_expiry_interval => seconds(),
          p_receive_max => 1..65535,
          p_topic_alias_max => 1..65535,
          p_max_packet_size => 1..4294967296,
          p_request_response_info => boolean(),
          p_request_problem_info => boolean(),
          p_user_property => [user_property()]
         }.

-type reg_modifiers()   ::
        #{
           clean_start => flag(),
           max_message_size => non_neg_integer(),
           subscriber_id => subscriber_id(),
           shared_subscription_policy => shared_sub_policy(),
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
