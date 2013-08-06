gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/vim'

describe Vim do

  def ctrl_R
    "\x12" # Ruby string notation for ctrl_R
  end

  it 'accepts viwhello<Esc>' do
    Vim.new(events = []).process("A#{ctrl_R}=1+1\r\e")
    assert_equal events, [
      {:switch=>"A"},
      {:exp_reg=>"<C-r>="},
      {:input=>"1"},
      {:input=>"+"},
      {:input=>"1"},
      {:enter=>"<Enter>"},
      {:escape=>"<Esc>"}
    ]
  end

end
