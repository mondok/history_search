defmodule HistorySearchTest do
  use ExUnit.Case
  doctest HistorySearch

  test "can search via pid" do
    pid = HistoryDatabase.new("test/fixture.txt")
    res = HistoryDatabase.search(pid, "sudo nginx")
    assert res == {:ok, [{:record, "06/16/16", "sudo nginx"}]}
  end

  test "can search and pretty print" do
    pid = HistoryDatabase.new("test/fixture.txt")
    res = HistoryDatabase.search(pid, "sudo nginx")
    pp = StringHelpers.pretty_print(res)
    assert pp == "06/16/16: sudo nginx"
  end

  test "can use history search without file path" do
    options = %{command: "xxxxxxxxxxxx"}
    hs = HistorySearch.parse_search(options)
    assert hs
  end

  test "can use history search with file path" do
    options = %{command: "xxxxxxxxxxxx", file: "test/fixture.txt"}
    hs = HistorySearch.parse_search(options)
    assert hs
  end
end
