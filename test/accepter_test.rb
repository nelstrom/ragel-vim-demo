gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/accepter'

describe Accepter do

  it 'accepts motions, switches, and insertions' do
    assert Accepter.new.accept?("hellohello\e")
  end

  it 'rejects everything else' do
    refute Accepter.new.accept?("viw")
  end

end

