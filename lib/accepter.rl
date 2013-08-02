%%{
  machine accepter;

  motion = [hjklbwe0];
  switch = [iIaAsSoO];
  escape = 27;
  input  = (any - escape);

  insert_mode  := (
    input*
    escape @{ fret; }
  );

  normal_mode  := (
    motion |
    switch @{ fcall insert_mode; }
  )*;

}%%

class VimParser

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

end

