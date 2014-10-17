defmodule Ddd.Matcher.Step do

    def when_([key, :is, value], {pre, post}) do
        k = String.to_atom(key)
        case post[k] == value do
            true -> {:ok, {pre,post}}
            false -> {:fail, "Does not match"}
        end
    end

end
