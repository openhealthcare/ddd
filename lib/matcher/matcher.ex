
defmodule Ddd.Matcher do

    def process_block(filename, action, {pre, post}) do
        success = true

        File.stream!(filename, [:utf8, :read]) |> Enum.take_while fn(x) ->
            {ok, msg} = process_line(filename, String.strip(x), {action, pre, post})
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

    defp sentence_params(sentence) do
      Enum.map(Regex.scan(~r/[^\s"]+|"([^"]*)"/, sentence), &(hd(&1)))
         |> Enum.map(fn(x) ->
             case String.match?(x, ~r/\".*\"/) do
                true -> String.replace("#{x}", "\"", "")
                false -> String.to_atom(String.downcase(x))
            end
        end)
    end

    def process_line(filename, sentence, {action, pre, post}) do
      # Regex tokenises in such a way that "ward 9" is one token
      params = sentence_params(sentence)

      [f | args] = params
      apply(Ddd.Matcher.Step, func_name(f), [filename, args, {action, pre,post}] )
    end

    def can_evaluate?(sentence) do
      params = sentence_params(sentence)
      [f | args] = params

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
