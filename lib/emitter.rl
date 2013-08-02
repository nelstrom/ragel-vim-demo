%%{
  machine emitter;
  action H { @head = p }
  action T { @tail = p }
  action return { fret; }
  action push_insert_mode { fcall insert_mode; }

  action EmitMotion { @events << {motion: strokes} }
  action EmitSwitch { @events << {switch: strokes} }
  action EmitInput  { @events << {input:  strokes} }
  action EmitEscape { @events << {escape: '<Esc>' } }

  escape = 27             >H@T @EmitEscape;
  input  = (any - escape) >H@T @EmitInput;
  motion = [hjklbwe0]     >H@T @EmitMotion;
  switch = [iIaAsSoO]     >H@T @EmitSwitch;

  insert_mode  := (
    input*
    escape @return
  );

  normal_mode  := (
    motion |
    switch @push_insert_mode
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
