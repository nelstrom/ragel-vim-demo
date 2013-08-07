%%{
  machine vim;
  action H { @head = p }
  action T { @tail = p }

  # TOKENS
  ctrl_R = 18;
  escape = 27               >H@T @{ @events << {escape: '<Esc>'} };
  enter  = 13               >H@T @{ @events << {enter:  '<Enter>'} };
  motion = [hjklbwe0]       >H@T @{ @events << {motion: strokes} };
  start_insert = [iIaAsSoO] >H@T @{ @events << {switch: strokes} };
  exp_reg= ctrl_R '='       >H@T @{ @events << {exp_reg:'<C-r>='} };

  start_cmdline = ':'            >H@T @{ @events << {start_cmdline:  strokes} };
  start_visual = 'v'             >H@T @{ @events << {start_visual:  strokes} };
  text_object  = ([ai][bBpstwW]) >H@T @{ @events << {text_object:  strokes} };
  v_switch = [sScC]              >H@T @{ @events << {switch:  strokes} };

  input = (any - (escape | ctrl_R))
    >H@T @{ @events << {input:  strokes} };
  cmdline_input = (any - (escape | enter | ctrl_R))
    >H@T @{ @events << {input:  strokes} };

  # MODES
  expression_register_mode := (
    cmdline_input*
    (enter | escape) @{ fret; }
  );

  cmdline_mode := (
    (
      cmdline_input |
      exp_reg @{ fcall expression_register_mode; }
    )*
    (enter | escape) @{ fret; }
  );

  insert_mode  := (
    (
      input |
      exp_reg @{ fcall expression_register_mode; }
    )*
    escape @{ fret; }
  );

  visual_mode := (
    ( motion | text_object )*
    (
      v_switch @{ fnext insert_mode; } |
      escape   @{ fret; }
    )
  );

  normal_mode  := (
    motion |
    start_insert  @{ fcall insert_mode; } |
    start_visual  @{ fcall visual_mode; } |
    start_cmdline @{ fcall cmdline_mode; }
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
