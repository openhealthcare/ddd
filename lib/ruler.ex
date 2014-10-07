defmodule Ddd.Ruler do

  # Returns all of the rules that are currently defined in ddd.
  # This may be a lot, we should perhaps use a Ecto.Queryable
  # so that it can be refined.
  def rules do

    %{"total"  => 0,
      "offset" => 0,
      "limit"  => 0,
      "results" => []}
  end


end
