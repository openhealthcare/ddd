defmodule Ddd.Macros  do


  defmacro defrule(signature, body) do
    f = elem(signature, 0)
    vl = elem(signature, 2)

    m = Enum.map hd(tl(vl)), fn (x) ->
      case x do
        {_, _, _} -> ""
        _ -> x
      end
    end

    quote do
      @rules [[unquote(f)|unquote(m)] | @rules]
      def unquote(signature) do
        unquote(body[:do])
      end
    end
  end

end