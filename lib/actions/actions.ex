defmodule Ddd.Actions do

@moduledoc """
The functions defined in this module are intended to be 'step'-style
matches so that the then() function of Ddd.Matcher.Step can apply
against this module.
"""

    def email([recipient, :with, content], {pre, post}) do
        IO.puts "email action"

        {:ok, "Sent"}
    end

    def broadcast([msg], {pre, post}) do
        IO.puts "broadcast action"

        {:ok, "Sent"}
    end

    def return([msg], {pre, post}) do
        IO.puts "return action"

        {:ok, "Sent"}
    end

    def sms([msg, :to, number], {pre, post}) do
        IO.puts "sms action"

        {:ok, "Sent"}
    end

    def refer([:to, target], {pre, post}) do
        IO.puts "refer"

        {:ok, "Sent"}
    end

end

