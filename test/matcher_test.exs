defmodule MatcherTest do
  use ExUnit.Case
  
  @fb "foo/bar.behaviour"
  @pre %{}
  @post %{ "diagnosis" =>  [ %{ "name" => "CAP" }, %{ "name" => "GORD" } ] }

  test "Match on sample behaviour" do
    success = Ddd.Matcher.process_block("behaviours/sample/sample.behaviour", {@pre, @post})
    assert(success == true)

  end

  test "basic match for is" do
    pre = %{}
    post = %{ "key" => "friday"}

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" is \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" is \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for was" do
    pre = %{ "key" => "friday"}
    post = %{}

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for is/was case of atom" do
    pre = %{ "key"=> "friday"}
    post = %{ "key"=> "friday"}

    {ok, res} = Ddd.Matcher.process_line(@fb, "When \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line(@fb, "When \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for did contain" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did contain \"ord\"", {@post, @post}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did contain \"death\"", {@post, @post}
    assert ok == :fail
  end

end
