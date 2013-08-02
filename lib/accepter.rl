%%{
  machine accepter;

  escape = 27;
  input  = (any - escape);
  motion = [hjklbwe0];
  switch = [iIaAsSoO];

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
    eof = @data.length
    stack = []
    %% write init;
    %% write exec;
    return cs
  end

  def accept?(input)
    process(input) > 0
  end

end

