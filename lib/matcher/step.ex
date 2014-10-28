defmodule Ddd.Matcher.Step do
    import Ddd.Macros, only: [defrule: 2]
    alias Ddd.Actions, as: Actions

  @rules []

  @doc"""
  For a nested series of JSON objects MAP, find out if there is a
  property KEY with VALUE.

  KEY will be expressed as foo.bar.baz
  """
  def json_property_matches(key, map, value) do
    MapTraversal.map_apply(key, map, value,
      fn(x) -> Enum.any?(x, fn(y) -> y == value end) end,
      fn(x) -> x == value end)
  end

  @doc"""
  For a nested series of JSON objects MAP, find out if there is a
  property KEY with a value that contains VALUE.

  KEY will be expressed as foo.bar.baz
  """
  defp json_property_contains(key, map, value) do
    MapTraversal.map_apply(key, map, value,
      fn(x) -> Enum.any?(x, fn(y) -> String.contains? String.downcase(y), String.downcase(value) end) end,
      fn(x) -> String.contains? x, value end)
  end

  defp provide_result(success, err \\ "", {action, pre, post}) do
      case success do
        true ->
          {:ok, {pre,post}}
        false ->
          {:fail, err}
      end
  end

  defrule when_(behaviour, [key, :is, value], {action, pre, post}) do
      match = json_property_matches key, post, value
      provide_result match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :is, :not, value], {action, pre, post}) do
      match = json_property_matches key, post, value
      provide_result !match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :was, value], {action, pre, post}) do
      match = json_property_matches key, pre, value
      provide_result match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :was, :not, value], {action, pre, post}) do
      match = json_property_matches key, pre, value
      provide_result !match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :did, :contain, value], {action, pre, post}) do
    match = json_property_contains key, pre, value
    provide_result match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :did, :not, :contain, value], {action, pre, post}) do
    match = json_property_contains key, pre, value
    provide_result !match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :contains, value], {action, pre, post}) do
    match = json_property_contains key, post, value
    provide_result match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :does, :not, :contain, value], {action, pre, post}) do
    match = json_property_contains key, post, value
    provide_result !match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [key, :changed, :to, value], {action, pre, post}) do
    was = json_property_matches( key, pre, value)
    is = json_property_matches key, post, value
    match = !was and is
    provide_result match, "Does not match", {action, pre, post}
  end

  defrule when_(behaviour, [:admitted, :to, ward], {:admit, pre, post}) do
    match = json_property_matches "location.ward", post, ward
    provide_result match, "Does not match", {:admit, pre, post}
  end

  # def when_(behaviour, [], {action, pre, post}) do
  # end

  defrule then(behaviour, [h|t], {action, pre, post}) do
      # We want to apply the action h and pass t as the args
      apply(Actions, h, [behaviour, t, {action, pre, post}])
  end

end
