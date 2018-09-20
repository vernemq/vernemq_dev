%% @hidden
-module(on_offline_message_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_offline_message(SubscriberId  :: subscriber_id(),
                             QoS           :: qos(),
                             Topic         :: topic(),
                             Payload       :: payload(),
                             IsRetain      :: flag()) -> any().
