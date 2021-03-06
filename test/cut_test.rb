gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cut'

describe CutAccepter do

  def cutter
    @cutter ||= CutAccepter.new
  end

  it 'accepts x' do
    assert cutter.accept?('x')
    assert cutter.accept?('2x')
    assert cutter.accept?('"ax')
    assert cutter.accept?('2"ax')
    assert cutter.accept?('"a2x')
    assert cutter.accept?('3"a2x')
  end

  it "doesn't accept double-digit counts" do
    assert cutter.reject?('22x')
  end

end
