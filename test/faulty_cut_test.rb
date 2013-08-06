gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/faulty_cut'

describe FaultyCutAccepter do

  def cutter
    @cutter ||= FaultyCutAccepter.new
  end

  it 'accepts x' do
    assert cutter.accept?('x')
    assert cutter.accept?('2x')
    assert cutter.accept?('"ax')
    assert cutter.accept?('2"ax')
    assert cutter.accept?('"a2x')
    assert cutter.accept?('3"a2x')
  end

  it "shouldn't accept double-digit counts" do
    skip
    assert cutter.reject?('22x'), "[count][register][count]x"
  end

end
