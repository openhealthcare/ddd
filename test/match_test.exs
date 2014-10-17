defmodule MatchTest do
  use ExUnit.Case

  test "basic match for is" do
    pre = %{}
    post = %{ "key": "friday"}

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for was" do
    pre = %{ "key": "friday"}
    post = %{}

    {ok, res} = Ddd.Matcher.process_line("when \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("when \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end
end
