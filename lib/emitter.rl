%%{
  machine emitter;
  action H { @head = p }
  action T { @tail = p }

  motion = [hjklbwe0]     >H@T @{ @events << {motion: strokes} };
  switch = [iIaAsSoO]     >H@T @{ @events << {switch: strokes} };
  escape = 27             >H@T @{ @events << {escape: '<Esc>'} };
  input  = (any - escape) >H@T @{ @events << {input:  strokes} };

  insert_mode  := (
    input*
    escape @{ fret; }
  );

  normal_mode  := (
    motion |
    switch @{ fcall insert_mode; }
  )*;

}%%

class Emitter

  attr_accessor :data

  def initialize(listener=[])
    @events = listener
    %% write data;
  end

  def process(input)
    @data = input.unpack("c*")
    stack = []
    %% write init;
    %% write exec;
  end

  def strokes
    @data[@head..@tail].pack('c*')
  end

end
