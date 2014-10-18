
defmodule Ddd.Matcher do

    def process_block(filename, {pre, post}) do
        success = true

        File.stream!(filename, [:utf8, :read]) |> Enum.take_while fn(x) ->
            {ok, msg} = process_line(filename, String.strip(x), {pre, post})
            case ok do
                :fail ->
                  success = false
                  false   # Abort (the take_while)
                :ok ->
                  IO.puts "MATCH!"
                  true
            end
        end

        success
    end

    def process_line(filename, sentence, {pre, post}) do
        params = String.split(sentence, " ")
         |> Enum.map(fn(x) ->
             case String.match?(x, ~r/\".*\"/) do
                true -> String.replace("#{x}", "\"", "")
                false -> String.to_atom(String.downcase(x))
            end
        end)

        [f | args] = params
        apply(Ddd.Matcher.Step, func_name(f), [filename, args, {pre,post}] )
    end


    def func_name(str) do
        # Replace when at start with when_
        case str do
            :when ->
                :when_
            :and ->
                :when_
            _ ->
                str
        end
    end


end
