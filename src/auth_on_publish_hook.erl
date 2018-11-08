%% @hidden
-module(auth_on_publish_hook).
-include("vernemq_dev_int.hrl").
-callback auth_on_publish(UserName      :: username(),
                          SubscriberId  :: subscriber_id(),
                          QoS           :: qos(),
                          Topic         :: topic(),
                          Payload       :: payload(),
                          IsRetain      :: flag()) -> ok
                                                      | {ok, Payload    :: payload()}
                                                      | {ok, Modifiers  :: [msg_modifier()]}
                                                      | {error, Reason  :: any()}
                                                      | next.

-type msg_modifier() ::
        %% Change the topic of the message.
        {topic, topic()}

        %% Change the payload of the message.
      | {payload, payload()}

        %% Change the QoS of the message.
      | {qos, qos()}

        %% Change the retain flag of the message.
      | {retain, flag()}

        %% Change the mountpoint where the message is
        %% published.
      | {mountpoint, mountpoint()}

        %% Throttle the publisher for a number of
        %% milliseconds. Note, there is no
        %% back-pressure for websocket connections.
      | {throttle, milliseconds()}.


-export_type([msg_modifier/0]).
