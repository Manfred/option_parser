# Copyright (c) 2010, Fingertips, Manfred Stienstra <manfred@fngtps.com>
# License: http://www.opensource.org/licenses/mit-license.php

require 'test/unit'
require 'benchmark'

require 'option_parser'

class OptionParserTest < Test::Unit::TestCase
  EXAMPLES = [
    [%w(), {}, %w()],
    [%w(create), {}, %w(create)],
    [%w(-h -i), {'h' => nil, 'i' => nil}, %w()],
    [%w(-i 1), {'i' => '1'}, %w()],
    [%w(create -h),
      {'h' => nil},
      %w(create)],
    [%w(create -h --username sjaak),
      {'username' => 'sjaak', 'h' => nil},
      %w(create)],
    [%w(create -h --username sjaak --use-password secret -i -t 12),
      {'username' => 'sjaak', 'use-password' => 'secret', 't' => '12', 'i' => nil, 'h' => nil}, 
      %w(create)]
  ]
  
  def test_parsing
    EXAMPLES.each do |input, options, rest|
      assert_equal [options, rest], OptionParser.parse(input)
    end
  end
  
  def test_performance
    puts(Benchmark.measure do
      10000.times do
        EXAMPLES.each { |input, _, _| OptionParser.parse(input) }
      end
    end)
  end
end