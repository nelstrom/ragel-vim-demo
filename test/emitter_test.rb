gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/emitter'

describe Emitter do

  it 'accepts motions, switches, and insertions' do
    Emitter.new(events = []).process("hellohello\e")
    assert_equal events, [
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
