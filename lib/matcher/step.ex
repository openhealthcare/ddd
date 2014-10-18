defmodule Ddd.Matcher.Step do
    alias Ddd.Actions, as: Actions

  @doc"""
  Recursively lookup KEY in MAP where KEY can be a . separated
  string where . indicates a level down in the nested MAP
  """
  def get_value(key, map) do
    [head | tail] = String.split to_string(key), "."

    if tail == [] do
      if is_map map do
        map[key]
      else
        Enum.map( map, fn(x) -> x[to_string(key)] end )
      end
    else
      get_value tail, map[head]
    end
  end

  @doc"""
  For a nested series of JSON objects MAP, find out if there is a
  property KEY with VALUE.

  KEY will be expressed as foo.bar.baz
  """
  def json_property_matches(key, map, value) do
    jsonvalue = get_value key, map
    if is_list jsonvalue do
      Enum.any? jsonvalue, fn(x) -> x == value end
    else
      jsonvalue == value
    end
  end

  def when_([key, :is, value], {pre, post}) do
    match = json_property_matches key, post, value
    case match do
      true ->
        {:ok, {pre,post}}
      false ->
        {:fail, "Does not match"}
    end
  end

    def when_([key, :was, value], {pre, post}) do
        match = json_property_matches key, pre, value
        case match do
          true ->
            {:ok, {pre, post}}
          false ->
            {:fail, "Does not match"}
        end
    end

    def then([h|t], {pre, post}) do
        # We want to apply the action h and pass t as the args
        apply(Actions, h, [t, {pre,post}])
    end

end
