defmodule Ddd.Rules do
  
  defp to_ruletree(tree, rules) do
    if length(rules) == 0 do
      tree
    else
      [h | t] = rules
      [dir | behaviour] = tl(String.split(h, "/")) # lose the behaviours folder
      IO.puts "#{inspect dir}, #{inspect behaviour}"
      if Dict.has_key? tree, dir do
        val = tree[dir] ++ behaviour
        tree = Dict.put tree, dir, val
      else
        tree = Dict.put tree, dir, behaviour
      end
      to_ruletree tree, t
    end
  end

  def ruletree do
    to_ruletree %{}, Path.wildcard("behaviours/*/*.behaviour")
  end

  def contents(path) do
    target = "behaviours/#{path}"
    IO.puts target
    {:ok, bin } = File.read target
    bin
  end
  
  def update(rule, contents) do
    File.write rule, contents
  end
  
end
