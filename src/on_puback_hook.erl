%% @hidden
-module(on_puback_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_puback(UserName      :: username(),
    SubscriberId  :: subscriber_id(),
    QoS           :: qos(),
    Topic         :: topic(),
    Payload       :: payload(),
    IsRetain      :: flag()) -> any().