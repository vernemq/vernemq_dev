%% @hidden
-module(on_topic_unsubscribed_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_topic_unsubscribed(SubscriberId    :: subscriber_id(),
                                MaybeTopics     :: maybe_topics()) -> any().

-type maybe_topics() ::
    all_topics
    | [topic()].


-export_type([maybe_topics/0]).
