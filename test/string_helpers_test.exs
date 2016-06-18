defmodule StringHelpersTest do
  use ExUnit.Case
  doctest StringHelpers

  test "can match content" do
    command = "ls -la"
    pattern = "ls"
    assert StringHelpers.match_content(command, pattern)
  end

  test "cannot match wrong content" do
    command = "ls -la"
    pattern = "grep"
    assert StringHelpers.match_content(command, pattern) == false
  end

  test "will trim nil to zero" do
    t = nil
    assert StringHelpers.trim(t) == "0"
  end

  test "will trim value" do
    t = "  hi "
    assert StringHelpers.trim(t) == "hi"
  end
end
