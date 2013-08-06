gem "minitest"
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/visual'

describe Visual do

  it 'accepts v<Esc>' do
    Visual.new(events = []).process("v\e")
    assert_equal events, [
      {:start_visual=>"v"},
      {:escape=>"<Esc>"}
    ]
  end

  it 'accepts viwhello<Esc>' do
    Visual.new(events = []).process("vhjkliwchello\ehell")
    assert_equal events, [
      {:start_visual=>"v"},
      {:motion=>"h"},
      {:motion=>"j"},
      {:motion=>"k"},
      {:motion=>"l"},
      {:text_object=>"iw"},
      {:switch=>"c"},
      {:input=>"h"},
      {:input=>"e"},
      {:input=>"l"},
      {:input=>"l"},
      {:input=>"o"},
      {:escape=>"<Esc>"},
      {:motion=>"h"},
      {:motion=>"e"},
      {:motion=>"l"},
      {:motion=>"l"}
    ]
  end

end
