defmodule Ddd.Matcher.Step do
    alias Ddd.Actions, as: Actions


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

    defp provide_result(success, err \\ "", {pre, post}) do
        case success do
          true ->
            {:ok, {pre,post}}
          false ->
            {:fail, err}
        end
    end

    def when_(behaviour, [key, :is, value], {pre, post}) do
        match = json_property_matches key, post, value
        provide_result match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :is, :not, value], {pre, post}) do
        match = json_property_matches key, post, value
        provide_result !match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :was, value], {pre, post}) do
        match = json_property_matches key, pre, value
        provide_result match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :was, :not, value], {pre, post}) do
        match = json_property_matches key, pre, value
        provide_result !match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :did, :contain, value], {pre, post}) do
      match = json_property_contains key, pre, value
      provide_result match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :did, :not, :contain, value], {pre, post}) do
      match = json_property_contains key, pre, value
      provide_result !match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :contains, value], {pre, post}) do
      match = json_property_contains key, post, value
      provide_result match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :does, :not, :contain, value], {pre, post}) do
      match = json_property_contains key, post, value
      provide_result !match, "Does not match", {pre, post}
    end

    def when_(behaviour, [key, :changed, :to, value], {pre, post}) do
      was = json_property_matches( key, pre, value)
      is = json_property_matches key, post, value
      match = !was and is
      provide_result match, "Does not match", {pre, post}
    end

    # def when_(behaviour, [], {pre, post}) do
    # end

    def then(behaviour, [h|t], {pre, post}) do
        # We want to apply the action h and pass t as the args
        apply(Actions, h, [behaviour, t, {pre, post}])
    end

end
