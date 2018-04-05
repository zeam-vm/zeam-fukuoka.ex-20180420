```elixir
filename
  	|> File.stream!

  	# データクレンジング
  	|> Flow.from_enumerable()
  	|> Flow.map( &( String.replace( &1, ",",    "\t" )   	# ①CSV→TSV
  	                |> String.replace( "\r\n", "\n" )    	# ②CRLF→LF
  	                |> String.replace(  "\"",   ""  ) ) )  # ③ダブルクォート外し
  	# 集計
  	|> Flow.map( &( &1 |> String.split( "\t" ) ) )    	# ④タブで分割
  	|> Flow.map( &Enum.at( &1, 2 - 1 ) )      	# ⑤2番目の項目を抽出
  	|> Flow.partition
      |> Flow.reduce(fn -> :ets.new(:words, []) end, fn word, ets -> # ETS
        :ets.update_counter(ets, word, {2, 1}, {word, 0})
        ets
      end)
      |> Flow.map_state(fn ets ->         # ETS
        :ets.give_away(ets, parent, [])   # オーナーを変える
        [ets]
      end)
      |> Enum.to_list
      |> Enum.flat_map( &(:ets.tab2list(&1)) )
  	|> Enum.sort( &( elem( &1, 1 ) > elem( &2, 1 ) ) )    # ⑦多い順でソート
```
