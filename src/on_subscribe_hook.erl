-module(on_subscribe_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_subscribe(UserName      :: username(),
                       SubscriberId  :: subscriber_id(),
                       Topics        :: [{Topic :: topic(), QoS :: qos()}]) -> any().

