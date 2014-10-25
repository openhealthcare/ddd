defmodule RulesTest do
  use ExUnit.Case


  test "get rule tree" do
    tree = Ddd.Rules.ruletree
    assert "sample.behaviour" in tree["sample"]
    assert "my.behaviour" in tree["sample"]
  end

end
