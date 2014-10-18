defmodule Ddd.Matcher.Step do

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

end
