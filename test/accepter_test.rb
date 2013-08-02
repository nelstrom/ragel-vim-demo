gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/accepter'

describe VimParser do

  it 'accepts motions, switches, and insertions' do
    assert VimParser.new.accept?("hellohello\e")
  end

  it 'rejects everything else' do
    refute VimParser.new.accept?("viw")
  end

end

