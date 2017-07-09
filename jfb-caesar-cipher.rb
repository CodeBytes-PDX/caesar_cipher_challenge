#!/usr/bin/env ruby

def string_shift(string_in, shift_val)
    string_out = ''
    (0..string_in.size-1).each { |i|
	char = string_in[i]

	if char >= 'a' and char <= 'z'
	    string_out += ((char.ord - 'a'.ord + shift_val) % 26 + 'a'.ord).chr
	else
	    string_out += char
	end
    }
    return string_out
end

if ARGV.size < 2 or ! ARGV[0].match(/^-?\d+/)
    $stderr.puts "usage:\t#{__FILE__} <shift> <string> [ <string> ... ]\n\tshift value of 0 will attempt a brute-force decoding"
    exit(1)
end

string_in = ''
c_shift = ARGV.shift.to_i
ARGV.each { |arg|
    string_in += "#{arg.downcase} "
}
string_in = string_in.sub(/\s+$/, '')

if c_shift == 0
    dict = {}
    File.read('/usr/share/dict/words').split(/[\s\r\n]+/).each { |word|
	dict[word] = 1
    }
    (-13..12).each { |c_shift|
	next if c_shift == 0
	encoded = string_shift(string_in, c_shift)
	words = encoded.split(/[^a-z]+/)
	matched_words = 0
	words.each { |c_word|
	    matched_words += 1 if dict[c_word]
	}
	if matched_words / words.size > 0.9
	    words_str = ""
	    words.each { |w|
		words_str += "#{w} "
	    }
	    words_str = words_str.sub(/\s+$/, '')
	    puts "'#{string_in}' shifted by #{c_shift} => over 90% dictionary words:\n\t" + words_str
	end
    }
else
    puts string_shift(string_in, c_shift)
end
