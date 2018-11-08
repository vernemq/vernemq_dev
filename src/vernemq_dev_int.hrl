-include("vernemq_dev.hrl").

-type utf8string() :: binary().
-type milliseconds() :: non_neg_integer().
-type seconds() :: non_neg_integer().
-type user_property() :: {utf8string(), utf8string()}.
-type subscription_id() :: 1..268435455.
