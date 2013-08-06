gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/vim'

describe Vim do

  def ctrl_R
    "\x12" # Ruby string notation for <C-r>
  end

  it 'can switch from insert mode to expression register and back' do
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

  it 'can switch from cmdline mode to expression register and back' do
    Vim.new(events = []).process(":#{ctrl_R}=1+1\r\r")
    assert_equal events, [
      {:start_cmdline=>":"},
      {:exp_reg=>"<C-r>="},
      {:input=>"1"},
      {:input=>"+"},
      {:input=>"1"},
      {:enter=>"<Enter>"},
      {:enter=>"<Enter>"}
    ]
  end

end
