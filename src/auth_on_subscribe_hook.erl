%% @hidden
-module(auth_on_subscribe_hook).
-include("vernemq_dev.hrl").

%% called as an all_till_ok - hook
-callback auth_on_subscribe(UserName      :: username(),
                            SubscriberId  :: subscriber_id(),
                            Topics        :: [{Topic :: topic(), QoS :: qos()}]) -> ok
                                                                                  | {ok, [{Topic :: topic(), Qos :: qos()}]}
                                                                                  | {error, Reason :: any()}
                                                                                  | next.
