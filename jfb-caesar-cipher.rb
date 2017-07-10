#!/usr/bin/env ruby

# string_shift() is where all the shifting work happens

def string_shift(string_in, shift_val)
    string_out = ''
    (0..string_in.size-1).each { |i|
	char = string_in[i]

	if char >= 'a' and char <= 'z'
	    # this is the math that makes it work.
	    string_out += ((char.ord - 'a'.ord + shift_val) % 26 + 'a'.ord).chr
	else
	    string_out += char
	end
    }
    return string_out
end

### script body ###

# must have at least two parameters, the first of which must be a number
if ARGV.size < 2 or ! ARGV[0].match(/^-?\d+$/)
    $stderr.puts "usage:\t#{__FILE__} <shift> <string> [ <string> ... ]\n\tshift value of 0 will attempt a brute-force decoding"
    exit(1)
end

c_shift = ARGV.shift.to_i
string_in = ARGV.shift.downcase
ARGV.each { |arg|
    string_in += " #{arg.downcase}"
}

# as the help message states, a shift value of 0 will attempt a
# brute-force decoding, using all shifts from 1-25.
if c_shift == 0

    # create a hash of all dictionary words for easy checking. downcase
    # each word, since input is also downcased before processing.
    dict = {}
    File.read('/usr/share/dict/words').split(/[\s\r\n]+/).each { |word|
	dict[word.downcase] = 1
    }

    (1..25).each { |c_shift|
	encoded = string_shift(string_in, c_shift)
	words = encoded.split(/[^a-z]+/)
	matched_words = 0
	words.each { |c_word|
	    matched_words += 1 if dict[c_word]
	}
	# arbitrary percentage to determine whether match was successful.
	# can be a problem for short phrases; should probably be a
	# command-line parameter.
	if matched_words / words.size > 0.9
	    words_str = words.shift
	    words.each { |w|
		words_str += " #{w}"
	    }
	    puts "'#{string_in}' shifted by #{c_shift} => over 90% dictionary words:\n\t" + words_str
	end
    }
else
    # nonzero shift specified; just shift, print, and exit.
    puts string_shift(string_in, c_shift)
end
