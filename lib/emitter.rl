%%{
  machine emitter;
  action H { @head = p }
  action T { @tail = p }

  escape = 27             >H@T @{ @events << {escape: '<Esc>'} };
  input  = (any - escape) >H@T @{ @events << {input:  strokes} };
  motion = [hjklbwe0]     >H@T @{ @events << {motion: strokes} };
  switch = [iIaAsSoO]     >H@T @{ @events << {switch: strokes} };

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

  attr_accessor :head, :tail, :data, :events

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
