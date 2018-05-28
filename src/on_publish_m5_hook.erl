-module(on_publish_m5_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_publish_m5(UserName      :: username(),
                        SubscriberId  :: subscriber_id(),
                        QoS           :: qos(),
                        Topic         :: topic(),
                        Payload       :: payload(),
                        IsRetain      :: flag(),
                        Properties    :: properties()) -> any().
