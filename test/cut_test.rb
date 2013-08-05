gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cut'

describe CutAccepter do

  it 'accepts x' do
    assert CutAccepter.new.accept?('x')
    assert CutAccepter.new.accept?('2x')
    assert CutAccepter.new.accept?('"ax')
    assert CutAccepter.new.accept?('2"ax')
    assert CutAccepter.new.accept?('"a2x')
    assert CutAccepter.new.accept?('3"a2x')
  end

end
