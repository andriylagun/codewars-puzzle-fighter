require "test/unit"
require_relative "../src/app.rb"

class GravityTest < BaseTestCase
  def test_moves_basic_games_down
    templates = [
      "     G", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "YYY   ", "      ",
      "      ", "      ",
      "      ", "      ",
      "R     ", "     G",
      "     Y", "     Y",
      "  R  Y", "Y Y  Y",
      "   YBY", "RYRYBY",
    ]

    input, expected = _set_from_ascii(templates)

    ascii_expected, ascii_output =
      _format_all(expected.sort, Gravity.call(input).sort)

    assert_equal ascii_expected, ascii_output
  end

  def test_does_not_move_power_blocks_down
    input, expected = _set_from_ascii [
      "     Y", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "  B   ", "      ",
      " Y    ", "      ",
      "      ", " YB   ",
      "RRRR  ", "RRRR  ",
      "RRRR Y", "RRRR Y",
      "   R  ", "   R Y",
      "   BBY", "   BBY",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end

  def test_does_move_down_trapped_blocks
    input, expected = _set_from_ascii [
      "     Y", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "  B   ", "      ",
      " Y    ", "      ",
      "      ", " YB   ",
      "RRRR  ", "RRRR  ",
      "RRRR Y", "RRRR Y",
      " G B  ", "   B Y",
      "   BBY", "   BBY",
      "   BBB", " G BBB",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end

  def test_does_not_move_multiple_power_blocks
    input, expected = _set_from_ascii [
      "     Y", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "  B   ", "     Y",
      " Y GGG", "   GGG",
      "   GGG", " YBGGG",
      "RRRR  ", "RRRR  ",
      "RRRR Y", "RRRR  ",
      " G B  ", "   B Y",
      "   BBY", "   BBY",
      "   BBB", " G BBB",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end

  def test_does_move_hanging_power_blocks
    input, expected = _set_from_ascii [
      "     Y", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "  BGGG", "     Y",
      " Y GGG", "   GGG",
      "      ", " YBGGG",
      "RRRR  ", "RRRR  ",
      "RRRR Y", "RRRR  ",
      " G B  ", "   B Y",
      "   BBY", "   BBY",
      "   BBB", " G BBB",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end

  def test_does_move_trapped_power_block
    input, expected = _set_from_ascii [
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      "      ", "      ",
      " BBBB ", " BBBB ",
      "RBBBB ", " BBBB ",
      " RR G ", "    G ",
      " RRBG ", " RR G ",
      "    G ", "RRRBG ",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end

  def test_does_move_combined_power_gems
    input, expected = _set_from_ascii [
      "      ", "      ",
      "      ", "      ",
      " YG   ", "      ",
      "BBB   ", "      ",
      "BBB   ", " YG   ",
      "RRRR  ", "BBB   ",
      "RRRR  ", "BBB   ",
      "RRRR  ", "RRRR  ",
      "   RRR", "RRRR  ",
      "  GRR ", "RRRR  ",
      "      ", "   RRR",
      "     R", "  GRRR",
    ]

    board = Gravity.call PowerCombiner.call(input)

    assert_equal(*_format_all(expected.sort, board.sort))
  end
end
