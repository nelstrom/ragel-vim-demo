%%{
  machine faulty_cut;

  count       = [1-9];
  cut         = 'x';
  register    = '"' [a-z];
  cut_command =
    count?
    register?
    count?
    cut;

  normal_mode  := (cut_command)*;

}%%

class FaultyCutAccepter

  attr_accessor :data

  def initialize()
    %% write data;
  end

  def process(input)
    @data = input.unpack("c*")
    stack = []
    %% write init;
    %% write exec;
    return cs
  end

  def accept?(input)
    process(input) > 0
  end

  def reject?(input)
    !accept?(input)
  end

end
