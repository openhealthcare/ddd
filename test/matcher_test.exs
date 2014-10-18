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

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" is \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" is \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for is not" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" is not \"healthy\"", {@empty, @full}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" is not \"CAP\"", {@empty, @full}
    assert ok == :fail
  end

  test "basic match for was" do
    pre = %{ "key" => "friday"}
    post = %{}

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" was \"friday\"", {pre, post})
    assert(ok == :ok)

    {ok, res} = Ddd.Matcher.process_line(@fb, "when \"key\" was \"wednesday\"", {pre, post})
    assert(ok == :fail)
  end

  test "basic match for was not" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" was not \"healthy\"", {@full, @empty}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" was not \"CAP\"", {@full, @empty}
    assert ok == :fail
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
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did contain \"ord\"", {@full, @empty}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did contain \"death\"", {@full, @empty}
    assert ok == :fail
  end

  test "basic match for contains" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" contains \"ord\"", {@empty, @full}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" contains \"death\"", {@empty, @full}
    assert ok == :fail
  end

  test "basic match for did not contain" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did not contain \"death\"", {@full, @empty}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" did not contain \"ord\"", {@full, @empty}
    assert ok == :fail
  end

  
  test "basic match for does not contain" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" does not contain \"death\"", {@empty, @full}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" does not contain \"ord\"", {@empty, @full}
    assert ok == :fail
  end

  test "basic match for changed to" do
    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" changed to \"CAP\"", {@empty, @full}
    assert ok == :ok

    {ok, res} = Ddd.Matcher.process_line @fb, "When \"diagnosis.name\" changed to \"healthy\"", {@empty, @full}
    assert ok == :fail
  end


end
