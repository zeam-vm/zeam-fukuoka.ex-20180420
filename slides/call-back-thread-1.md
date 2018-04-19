## Flow / GenStage で並列実行してくれない場合

```
1..10
|> Stream.map(fn i -> i end)
|> Flow.from_enumerable(stages: 10)
  # max_demand を指定しないので，ストリームが分割されず，並列実行してくれない
|> Flow.map(fn i -> Process.sleep(500); i end)
|> Flow.partition
|> Enum.to_list
|> Enum.sort
```

* Flowはストリームをある程度まとめる
* ストリーム中にある`Process.sleep`で実行がブロックされてしまう
* したがって，Flow / GenStage では**待ちがあると効率よく実行できない**