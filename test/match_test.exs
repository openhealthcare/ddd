defmodule MatchTest do
  use ExUnit.Case

  test "basic match for is" do
    pre = %{}
    post = %{ "key" => "friday"}

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("when \"key\" is \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for was" do
    pre = %{ "key" => "friday"}
    post = %{}

    {ok, res} = Ddd.Matcher.process_line("when \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("when \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for is/was case of atom" do
    pre = %{ "key"=> "friday"}
    post = %{ "key"=> "friday"}

    {ok, res} = Ddd.Matcher.process_line("When \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line("When \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "sample behaviour" do
    pre = %{ "key"=> "friday"}
    post = %{ "diagnosis"=> "CAP"}

    assert( true ==  Ddd.Matcher.process_block("behaviours/sample/sample.behaviour", {pre, post}) )

  end

end
