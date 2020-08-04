-ifndef(VERNEMQ_DEV_HRL).
-define(VERNEMQ_DEV_HRL, true).
-define(true, 1).
-define(false, 0).
-type peer()                :: {inet:ip_address(), inet:port_number()}.
-type username()            :: binary() | undefined.
-type password()            :: binary() | undefined.
-type client_id()           :: binary().
-type mountpoint()          :: string().
-type subscriber_id()       :: {mountpoint(), client_id()}.
-type reg_view()            :: atom().
-type topic()               :: [binary()] | binary(). %% binary() for test purposes only.
-type qos()                 :: 0 | 1 | 2.
-type payload()             :: binary().
-type flag()                :: ?true | ?false | boolean() | empty. % empty for test purposes only
-type subopts() :: map().
-type subinfo() :: qos() | {qos(), subopts()}.
-type properties() :: map().
-type shared_sub_policy() :: prefer_local | local_only | random.
-type hook_name() :: 'on_register' | 'on_register_m5' | 'auth_on_publish' | 'auth_on_publish_m5' | 'auth_on_register' | 'auth_on_register_m5' 
| 'auth_on_subscribe' | 'auth_on_subscribe_m5' | 'on_auth_m5' | 'on_deliver' | 'on_deliver_m5' | 'on_unsubscribe' 
| 'on_unsubscribe_m5' | 'on_publish' | 'on_publish_m5' | 'on_subscribe' | 'on_subscribe_m5' | 'on_message_drop' | 'on_topic_unsubscribed' | 
'on_session_expired' | 'on_offline_message' | 'on_config_change' | 'on_client_wakeup' | 'on_client_offline' | 'on_client_gone'.

%% reason codes names
-define(SUCCESS,                        success).
-define(NORMAL_DISCONNECT,              normal_disconnect).
-define(GRANTED_QOS0,                   granted_qos0).
-define(GRANTED_QOS1,                   granted_qos1).
-define(GRANTED_QOS2,                   granted_qos2).
-define(DISCONNECT_WITH_WILL_MSG,       disconnect_with_will_msg).
-define(NO_MATCHING_SUBSCRIBERS,        no_matching_subscribers).
-define(NO_SUBSCRIPTION_EXISTED,        no_subscription_existed).
-define(CONTINUE_AUTHENTICATION,        continue_authentication).
-define(REAUTHENTICATE,                 reauthenticate).
-define(UNSPECIFIED_ERROR,              unspecified_error).
-define(MALFORMED_PACKET,               malformed_packet).
-define(PROTOCOL_ERROR,                 protocol_error).
-define(IMPL_SPECIFIC_ERROR,            impl_specific_error).
-define(UNSUPPORTED_PROTOCOL_VERSION,   unsupported_protocol_version).
-define(CLIENT_IDENTIFIER_NOT_VALID,    client_identifier_not_valid).
-define(BAD_USERNAME_OR_PASSWORD,       bad_username_or_password).
-define(NOT_AUTHORIZED,                 not_authorized).
-define(SERVER_UNAVAILABLE,             server_unavailable).
-define(SERVER_BUSY,                    server_busy).
-define(BANNED,                         banned).
-define(SERVER_SHUTTING_DOWN,           server_shutting_down).
-define(BAD_AUTHENTICATION_METHOD,      bad_authentication_method).
-define(KEEP_ALIVE_TIMEOUT,             keep_alive_timeout).
-define(SESSION_TAKEN_OVER,             session_taken_over).
-define(TOPIC_FILTER_INVALID,           topic_filter_invalid).
-define(TOPIC_NAME_INVALID,             topic_name_invalid).
-define(PACKET_ID_IN_USE,               packet_id_in_use).
-define(PACKET_ID_NOT_FOUND,            packet_id_not_found).
-define(RECEIVE_MAX_EXCEEDED,           receive_max_exceeded).
-define(TOPIC_ALIAS_INVALID,            topic_alias_invalid).
-define(PACKET_TOO_LARGE,               packet_too_large).
-define(MESSAGE_RATE_TOO_HIGH,          message_rate_too_high).
-define(QUOTA_EXCEEDED,                 quota_exceeded).
-define(ADMINISTRATIVE_ACTION,          administrative_action).
-define(PAYLOAD_FORMAT_INVALID,         payload_format_invalid).
-define(RETAIN_NOT_SUPPORTED,           retain_not_supported).
-define(QOS_NOT_SUPPORTED,              qos_not_supported).
-define(USE_ANOTHER_SERVER,             use_another_server).
-define(SERVER_MOVED,                   server_moved).
-define(SHARED_SUBS_NOT_SUPPORTED,      shared_subs_not_supported).
-define(CONNECTION_RATE_EXCEEDED,       connection_rate_exceeded).
-define(MAX_CONNECT_TIME,               max_connect_time).
-define(SUBSCRIPTION_IDS_NOT_SUPPORTED, subscription_ids_not_supported).
-define(WILDCARD_SUBS_NOT_SUPPORTED,    wildcard_subs_not_supported).

%% properties

-define(P_PAYLOAD_FORMAT_INDICATOR, p_payload_format_indicator).
-define(P_MESSAGE_EXPIRY_INTERVAL, p_message_expiry_interval).
-define(P_CONTENT_TYPE, p_content_type).
-define(P_RESPONSE_TOPIC, p_response_topic).
-define(P_CORRELATION_DATA, p_correlation_data).
-define(P_SUBSCRIPTION_ID, p_subscription_id).
-define(P_SESSION_EXPIRY_INTERVAL, p_session_expiry_interval).
-define(P_ASSIGNED_CLIENT_ID, p_assigned_client_id).
-define(P_SERVER_KEEP_ALIVE, p_server_keep_alive).
-define(P_AUTHENTICATION_METHOD, p_authentication_method).
-define(P_AUTHENTICATION_DATA, p_authentication_data).
-define(P_REQUEST_PROBLEM_INFO, p_request_problem_info).
-define(P_WILL_DELAY_INTERVAL, p_will_delay_interval).
-define(P_REQUEST_RESPONSE_INFO, p_request_response_info).
-define(P_RESPONSE_INFO, p_response_info).
-define(P_SERVER_REF, p_server_ref).
-define(P_REASON_STRING, p_reason_string).
-define(P_RECEIVE_MAX, p_receive_max).
-define(P_TOPIC_ALIAS_MAX, p_topic_alias_max).
-define(P_TOPIC_ALIAS, p_topic_alias).
-define(P_MAX_QOS, p_max_qos).
-define(P_RETAIN_AVAILABLE, p_retain_available).
-define(P_USER_PROPERTY, p_user_property).
-define(P_MAX_PACKET_SIZE, p_max_packet_size).
-define(P_WILDCARD_SUBS_AVAILABLE, p_wildcard_subs_available).
-define(P_SUB_IDS_AVAILABLE, p_sub_ids_available).
-define(P_SHARED_SUBS_AVAILABLE, p_shared_subs_available).

-type reason_code_name() :: ?SUCCESS
                          | ?GRANTED_QOS0
                          | ?GRANTED_QOS1
                          | ?GRANTED_QOS2
                          | ?DISCONNECT_WITH_WILL_MSG
                          | ?NO_MATCHING_SUBSCRIBERS
                          | ?NO_SUBSCRIPTION_EXISTED
                          | ?CONTINUE_AUTHENTICATION
                          | ?REAUTHENTICATE
                          | ?UNSPECIFIED_ERROR
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
                          | ?SERVER_SHUTTING_DOWN
                          | ?BAD_AUTHENTICATION_METHOD
                          | ?KEEP_ALIVE_TIMEOUT
                          | ?SESSION_TAKEN_OVER
                          | ?TOPIC_FILTER_INVALID
                          | ?TOPIC_NAME_INVALID
                          | ?PACKET_ID_IN_USE
                          | ?PACKET_ID_NOT_FOUND
                          | ?RECEIVE_MAX_EXCEEDED
                          | ?TOPIC_ALIAS_INVALID
                          | ?PACKET_TOO_LARGE
                          | ?MESSAGE_RATE_TOO_HIGH
                          | ?QUOTA_EXCEEDED
                          | ?ADMINISTRATIVE_ACTION
                          | ?PAYLOAD_FORMAT_INVALID
                          | ?RETAIN_NOT_SUPPORTED
                          | ?QOS_NOT_SUPPORTED
                          | ?USE_ANOTHER_SERVER
                          | ?SERVER_MOVED
                          | ?SHARED_SUBS_NOT_SUPPORTED
                          | ?CONNECTION_RATE_EXCEEDED
                          | ?MAX_CONNECT_TIME
                          | ?SUBSCRIPTION_IDS_NOT_SUPPORTED
                          | ?WILDCARD_SUBS_NOT_SUPPORTED.

-endif.
