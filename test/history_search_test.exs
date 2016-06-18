defmodule HistorySearchTest do
  use ExUnit.Case
  doctest HistorySearch

  test "can search via pid" do
    pid = HistoryDatabase.new("test/test.txt")
    res = HistoryDatabase.search(pid, "sudo nginx")
    assert res == {:ok, [{:record, "06/16/16", "sudo nginx"}]}
  end

  test "can search and pretty print" do
    pid = HistoryDatabase.new("test/test.txt")
    res = HistoryDatabase.search(pid, "sudo nginx")
    pp = StringHelpers.pretty_print(res)
    assert pp == "06/16/16: sudo nginx"
  end
end
