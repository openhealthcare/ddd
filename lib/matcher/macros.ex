defmodule Ddd.Macros  do


    defmacro defrule(signature, body) do
      quote do
        def unquote(signature) do
          unquote(body[:do])
        end
      end
    end

end