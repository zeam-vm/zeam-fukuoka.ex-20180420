```elixir
tasks = 1..10_000
|> Enum.map(fn i ->
  Task.async(fn -> Process.sleep(5000);
    i end)
  end)
tasks |> Enum.map( &Task.await &1 )
```
