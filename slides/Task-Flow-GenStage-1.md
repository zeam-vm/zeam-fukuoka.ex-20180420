## Task と Flow / GenStage の違い

### Task を使ったコード

```elixir
tasks = 1..10
|> Enum.map(fn i ->
  Task.async(fn -> Process.sleep(500);
    i end)
  end)
tasks |> Enum.map( &Task.await &1 )
```

### Flow / GenStage を使ったコード
```
1..10
|> Stream.map(fn i -> i end)
|> Flow.from_enumerable(max_demand: 1, stages: 10)
  # stages で並列実行する最大数を指定する
  # max_demand を指定しない，もしくは大きくしすぎると，並列実行してくれない
|> Flow.map(fn i -> Process.sleep(500); i end)
|> Flow.partition
|> Enum.to_list
|> Enum.sort
```