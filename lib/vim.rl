%%{
  machine vim;
  action H { @head = p }
  action T { @tail = p }

  ctrl_R = 18;
  motion = [hjklbwe0]     >H@T @{ @events << {motion: strokes} };
  switch = [iIaAsSoO]     >H@T @{ @events << {switch: strokes} };
  escape = 27             >H@T @{ @events << {escape: '<Esc>'} };
  enter  = 13             >H@T @{ @events << {enter:  '<Enter>'} };
  input  = (any - (escape|ctrl_R)) >H@T @{ @events << {input:  strokes} };
  cmdline_input  = (any - (escape|ctrl_R|enter)) >H@T @{ @events << {input:  strokes} };
  exp_reg= ctrl_R '='     >H@T @{ @events << {exp_reg:'<C-r>='} };

  start_visual = 'v'             >H@T @{ @events << {start_visual:  strokes} };
  text_object  = ([ai][bBpstwW]) >H@T @{ @events << {text_object:  strokes} };
  v_switch = [sScC]              >H@T @{ @events << {switch:  strokes} };

  expression_register_mode := (
    cmdline_input*
    enter @{ fret; }
  );

  insert_mode  := (
    (
      exp_reg @{ fcall expression_register_mode; } |
      input
    )*
    escape @{ fret; }
  );

  visual_mode := (
    ( motion | text_object )*
    (
      v_switch @{ fnext insert_mode; } |
      escape @{ fret; }
    )
  );

  normal_mode  := (
    motion |
    switch @{ fcall insert_mode; } |
    start_visual @{ fcall visual_mode; }
  )*;

}%%

class Vim

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
