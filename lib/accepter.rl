%%{
  machine accepter;
  action return { fret; }
  action push_insert_mode { fcall insert_mode; }

  escape = 27;
  input  = (any - escape);
  motion = [hjklbwe0];
  switch = [iIaAsSoO];

  insert_mode  := (
    input*
    escape @return
  );

  normal_mode  := (
    motion |
    switch @push_insert_mode
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

