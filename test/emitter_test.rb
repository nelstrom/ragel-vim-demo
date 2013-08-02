gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/emitter'

describe Emitter do

  def parser
    @parser ||= Emitter.new
  end

  it 'accepts motions, switches, and insertions' do
    parser.process("hellohello\e")
    assert_equal parser.events, [
      {:motion=>"h"},
      {:motion=>"e"},
      {:motion=>"l"},
      {:motion=>"l"},
      {:switch=>"o"},
      {:input=>"h"},
      {:input=>"e"},
      {:input=>"l"},
      {:input=>"l"},
      {:input=>"o"},
      {:escape=>"<Esc>"}
    ]
  end

end
