## コールバックスレッド

* Node.jsやZackernelと同等の並行処理の仕組みを提案
  * `Process.sleep`やI/O処理で区切った関数を内部的に定義する
  * これらの関数を順番に呼び出す
  * `Process.sleep`やI/O処理を**非同期的に**呼び出し，処理後に実行する関数をコールバックとして登録しておく
  * コールバックのリストの中から`Process.sleep`やI/O処理が完了したものを呼び出す
  * 完了したものがなければ完了するまで待つ
