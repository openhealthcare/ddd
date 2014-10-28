defmodule Ddd.Macros  do

defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
      @rules = []
    end
  end

  defmacro defrule(signature, body) do
    f = elem(signature, 0)
    vl = elem(signature, 2)

    m = Enum.map hd(tl(vl)), fn (x) ->
      case x do
        {_, _, _} -> ""
        _ -> x
      end
    end

    # We want to add this to @rules, but I am totally failing
    # IO.inspect [f|m]

    quote do
      def unquote(signature) do
        unquote(body[:do])
      end
    end
  end

end