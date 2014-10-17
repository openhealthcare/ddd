defmodule MatchTest do
  use ExUnit.Case

  test "basic match" do
    pre = %{}
    post = %{ "key": "friday"}

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end
end
