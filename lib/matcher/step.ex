defmodule Ddd.Matcher.Step do
    alias Ddd.Actions, as: Actions

    def when_([key, :is, value], {pre, post}) do
        case post[key] == value do
            true -> {:ok, {pre,post}}
            false -> {:fail, "Does not match"}
        end
    end

    def when_([key, :was, value], {pre, post}) do
        case pre[key] == value do
            true -> {:ok, {pre, post}}
            false -> {:fail, "Does not match"}
        end
    end

    def then([h|t], {pre, post}) do
        # We want to apply the action h and pass t as the args
        {ok, err} = apply(Actions, h, [t, {pre,post}])
        {ok, err}
    end

end
