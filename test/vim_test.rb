gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/vim'

describe Vim do

  before do
    @events = []
  end

  def scan(text)
    Vim.new(@events).process(text)
  end

  describe 'normal mode' do

    it "simple motions are recognised" do
      scan("hjklbwe0")
      assert_equal [
        {motion: 'h'},
        {motion: 'j'},
        {motion: 'k'},
        {motion: 'l'},
        {motion: 'b'},
        {motion: 'w'},
        {motion: 'e'},
        {motion: '0'},
      ], @events
    end

  end

  describe 'command line mode' do

    it 'aborts on <Esc>' do
      scan(":\e")
      assert_equal [
        {:start_cmdline=>":"},
        {:escape=>"<Esc>"}
      ], @events
    end

    it 'aborts a simple ":write" command' do
      scan(":write\e")
      assert_equal [
        {:start_cmdline=>":"},
        {:input => "w"},
        {:input => "r"},
        {:input => "i"},
        {:input => "t"},
        {:input => "e"},
        {:escape=>"<Esc>"}
      ], @events
    end

    it "executes a simple ':write' command" do
      scan(":write\r")
      assert_equal [
        {:start_cmdline=>":"},
        {:input => "w"},
        {:input => "r"},
        {:input => "i"},
        {:input => "t"},
        {:input => "e"},
        {:enter=>"<Enter>"}
      ], @events
    end

  end

  describe 'expression register' do

    def ctrl_R
      "\x12" # Ruby string notation for <C-r>
    end

    it 'can switch from insert mode to expression register and back' do
      scan("A#{ctrl_R}=1+1\r\e")
      assert_equal [
        {:switch=>"A"},
        {:exp_reg=>"<C-r>="},
        {:input=>"1"},
        {:input=>"+"},
        {:input=>"1"},
        {:enter=>"<Enter>"},
        {:escape=>"<Esc>"}
      ], @events
    end

    it 'can switch from cmdline mode to expression register and back' do
      scan(":#{ctrl_R}=1+1\r\r")
      assert_equal [
        {:start_cmdline=>":"},
        {:exp_reg=>"<C-r>="},
        {:input=>"1"},
        {:input=>"+"},
        {:input=>"1"},
        {:enter=>"<Enter>"},
        {:enter=>"<Enter>"}
      ], @events
    end


  end
end
