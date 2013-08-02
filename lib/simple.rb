
# line 1 "lib/simple.rl"

# line 28 "lib/simple.rl"


class VimParser

  attr_accessor :head, :tail, :data

  def initialize(listener)
    @events = listener
    
# line 15 "lib/simple.rb"
class << self
	attr_accessor :_vim_print_actions
	private :_vim_print_actions, :_vim_print_actions=
end
self._vim_print_actions = [
	0, 3, 0, 1, 4, 3, 0, 1, 
	6, 4, 0, 1, 5, 3, 4, 0, 
	1, 7, 2
]

class << self
	attr_accessor :_vim_print_key_offsets
	private :_vim_print_key_offsets, :_vim_print_key_offsets=
end
self._vim_print_key_offsets = [
	0, 0, 1, 15
]

class << self
	attr_accessor :_vim_print_trans_keys
	private :_vim_print_trans_keys, :_vim_print_trans_keys=
end
self._vim_print_trans_keys = [
	27, 48, 65, 73, 79, 83, 97, 98, 
	101, 105, 111, 115, 119, 104, 108, 0
]

class << self
	attr_accessor :_vim_print_single_lengths
	private :_vim_print_single_lengths, :_vim_print_single_lengths=
end
self._vim_print_single_lengths = [
	0, 1, 12, 0
]

class << self
	attr_accessor :_vim_print_range_lengths
	private :_vim_print_range_lengths, :_vim_print_range_lengths=
end
self._vim_print_range_lengths = [
	0, 0, 1, 0
]

class << self
	attr_accessor :_vim_print_index_offsets
	private :_vim_print_index_offsets, :_vim_print_index_offsets=
end
self._vim_print_index_offsets = [
	0, 0, 2, 16
]

class << self
	attr_accessor :_vim_print_indicies
	private :_vim_print_indicies, :_vim_print_indicies=
end
self._vim_print_indicies = [
	1, 0, 2, 4, 4, 4, 4, 4, 
	2, 2, 4, 4, 4, 2, 2, 3, 
	3, 0
]

class << self
	attr_accessor :_vim_print_trans_targs
	private :_vim_print_trans_targs, :_vim_print_trans_targs=
end
self._vim_print_trans_targs = [
	1, 3, 2, 0, 2
]

class << self
	attr_accessor :_vim_print_trans_actions
	private :_vim_print_trans_actions, :_vim_print_trans_actions=
end
self._vim_print_trans_actions = [
	5, 14, 1, 0, 9
]

class << self
	attr_accessor :vim_print_start
end
self.vim_print_start = 2;
class << self
	attr_accessor :vim_print_first_final
end
self.vim_print_first_final = 2;
class << self
	attr_accessor :vim_print_error
end
self.vim_print_error = 0;

class << self
	attr_accessor :vim_print_en_insert_mode
end
self.vim_print_en_insert_mode = 1;
class << self
	attr_accessor :vim_print_en_normal_mode
end
self.vim_print_en_normal_mode = 2;


# line 37 "lib/simple.rl"
  end

  def process(input)
    @data = input.unpack("c*")
    eof = @data.length
    stack = []
    
# line 124 "lib/simple.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = vim_print_start
	top = 0
end

# line 44 "lib/simple.rl"
    
# line 134 "lib/simple.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _vim_print_key_offsets[cs]
	_trans = _vim_print_index_offsets[cs]
	_klen = _vim_print_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _vim_print_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _vim_print_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _vim_print_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _vim_print_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _vim_print_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _vim_print_indicies[_trans]
	cs = _vim_print_trans_targs[_trans]
	if _vim_print_trans_actions[_trans] != 0
		_acts = _vim_print_trans_actions[_trans]
		_nacts = _vim_print_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _vim_print_actions[_acts - 1]
when 0 then
# line 3 "lib/simple.rl"
		begin
 @head = p 		end
when 1 then
# line 4 "lib/simple.rl"
		begin
 @tail = p 		end
when 2 then
# line 5 "lib/simple.rl"
		begin
 	begin
		top -= 1
		cs = stack[top]
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 3 then
# line 6 "lib/simple.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 1
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 4 then
# line 8 "lib/simple.rl"
		begin
 @events << {motion: strokes} 		end
when 5 then
# line 9 "lib/simple.rl"
		begin
 @events << {switch: strokes} 		end
when 6 then
# line 10 "lib/simple.rl"
		begin
 @events << {input:  strokes} 		end
when 7 then
# line 11 "lib/simple.rl"
		begin
 @events << {escape: '<Esc>' } 		end
# line 262 "lib/simple.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 45 "lib/simple.rl"
  end

  def strokes
    @data[@head..@tail].pack('c*')
  end

end

VimParser.new(recorder = []).process("helihello\e")
puts recorder
# {:motion=>"h"}
# {:motion=>"e"}
# {:motion=>"l"}
# {:switch=>"i"}
# {:input=>"h"}
# {:input=>"e"}
# {:input=>"l"}
# {:input=>"l"}
# {:input=>"o"}
# {:escape=>"<Esc>"}
