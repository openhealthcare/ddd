defmodule MatcherTest do
  use ExUnit.Case

  @fb "foo/bar.behaviour"
  @empty %{}
  @full %{ "diagnosis" =>  [ %{ "name" => "CAP" }, %{ "name" => "GORD" } ] }

  test "Match on sample behaviour" do
    success = Ddd.Matcher.process_block("behaviours/sample/sample.behaviour", {@empty, @full})
    assert(success == true)

  end

  test "basic match for is" do
    pre = %{}
    post = %{ "key" => "friday"}

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(when "key" is "friday"), {pre, post})
    assert(ok == :ok)

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(when "key" is "wednesday"), {pre, post})
    assert(ok == :fail)
  end

  test "basic match for is not" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" is not "healthy"), {@empty, @full}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" is not "CAP"), {@empty, @full}
    assert ok == :fail
  end

  test "basic match for was" do
    pre = %{ "key" => "friday"}
    post = %{}

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(when "key" was "friday"), {pre, post})
    assert(ok == :ok)

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(when "key" was "wednesday"), {pre, post})
    assert(ok == :fail)
  end

  test "basic match for was not" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" was not "healthy"), {@full, @empty}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" was not "CAP"), {@full, @empty}
    assert ok == :fail
  end

  test "basic match for is/was case of atom" do
    pre = %{ "key"=> "friday"}
    post = %{ "key"=> "friday"}

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(When "key" was "friday"), {pre, post})
    assert(ok == :ok)

    {ok, _} = Ddd.Matcher.process_line(@fb, ~s(When "key" was "wednesday"), {pre, post})
    assert(ok == :fail)
  end

  test "basic match for did contain" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" did contain "ord"), {@full, @empty}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" did contain "death"), {@full, @empty}
    assert ok == :fail
  end

  test "basic match for contains" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" contains "ord"), {@empty, @full}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" contains "death"), {@empty, @full}
    assert ok == :fail
  end

  test "basic match for did not contain" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" did not contain "death"), {@full, @empty}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" did not contain "ord"), {@full, @empty}
    assert ok == :fail
  end


  test "basic match for does not contain" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" does not contain "death"), {@empty, @full}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" does not contain "ord"), {@empty, @full}
    assert ok == :fail
  end

  test "basic match for changed to" do
    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" changed to "CAP"), {@empty, @full}
    assert ok == :ok

    {ok, _} = Ddd.Matcher.process_line @fb, ~s(When "diagnosis.name" changed to "healthy"), {@empty, @full}
    assert ok == :fail
  end


end
