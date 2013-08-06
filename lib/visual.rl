%%{
  machine visual;
  action H { @head = p }
  action T { @tail = p }

  motion = [hjklbwe0]     >H@T @{ @events << {motion: strokes} };
  switch = [iIaAsSoO]     >H@T @{ @events << {switch: strokes} };
  escape = 27             >H@T @{ @events << {escape: '<Esc>'} };
  input  = (any - escape) >H@T @{ @events << {input:  strokes} };

  start_visual = 'v'             >H@T @{ @events << {start_visual:  strokes} };
  text_object  = ([ai][bBpstwW]) >H@T @{ @events << {text_object:  strokes} };
  v_switch = [sScC]              >H@T @{ @events << {switch:  strokes} };

  insert_mode  := (
    input*
    escape @{ fret; }
  );

  visual_mode := (
    text_object |
    v_switch @{ fnext insert_mode; } |
    escape @{ fret; }
  )*;

  normal_mode  := (
    motion |
    switch @{ fcall insert_mode; } |
    start_visual @{ fcall visual_mode; }
  )*;

}%%

class Visual

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
