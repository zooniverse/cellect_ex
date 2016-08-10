defmodule Cellect.Random do
  def seed(seed) do
    :rand.seed(:exs1024, seed)
  end

  def element(enumerable) do
    size = Enum.count(enumerable)
    index = :rand.uniform(size) - 1
    element = Enum.at(enumerable, index)

    { index, element }
  end

  def weighted(enumerable) do
    weights = Enum.map(enumerable, &elem(&1, 1))
    total   = Enum.sum(weights)
    choice  = :rand.uniform() * total

    do_weighted(enumerable, choice, 0)
  end

  def do_weighted([{_, weight} = h | t], choice, index) do
    if weight >= choice do
      {index, h}
    else
      do_weighted(t, choice - weight, index + 1)
    end
  end

  def do_weighted([], choice, index) do
    throw :table
  end
end
