defmodule HistoryDatabaseTest do
  use ExUnit.Case
  doctest HistoryDatabase

  test "can read file" do
    contents = HistoryDatabase.read_file("test/fixture.txt")
    assert contents != nil
  end

  test "can parse file" do
    db = HistoryDatabase.read_file("test/fixture.txt") |> HistoryDatabase.parse
    assert db != nil
    assert Enum.count(db) == 8
  end

  test "can create database" do
    pid = HistoryDatabase.new("test/fixture.txt")
    assert pid != nil
  end

  test "can search database" do
    recs = HistoryDatabase.create_database("test/fixture.txt")
    res = HistoryDatabase.search_database("sudo nginx", recs)
    assert Enum.count(res) == 1
    assert List.first(res) == {:record, "06/16/16", "sudo nginx"}
  end
end
