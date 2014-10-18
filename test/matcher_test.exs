defmodule MatcherTest do
  use ExUnit.Case

  test "Match on sample behaviour" do
    IO.puts "yay"
    pre = %{}
    post = %{ "diagnosis" =>  [ %{ "name" => "CAP" }, %{ "name" => "GORD" } ] }

    {ok, res} = Ddd.Matcher.process_block("behaviours/sample/sample.behaviour", {pre, post})
    assert(ok == :ok)

  end

end
