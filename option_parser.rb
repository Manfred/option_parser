# Copyright (c) 2010, Fingertips, Manfred Stienstra <manfred@fngtps.com>
# License: http://www.opensource.org/licenses/mit-license.php

# Parser for command line options
class OptionParser
  # Parses ARGV from a Ruby script and returns options as a hash and
  # arguments as a list.
  #
  #   OptionParser.parse(%w(create --username manfred)) #=>
  #     [{"username"=>"manfred"}, ["create"]]
  def self.parse(argv)
    return [{},[]] if argv.empty?
    
    options  = {}
    rest     = []
    switch   = nil
    
    for value in argv
      # value is a switch
      if value[0] == 45
        switch = value.slice((value[1] == 45 ? 2 : 1)..-1)
        options[switch] = nil
      else
        if switch
          # we encountered another switch so this
          # value belongs to the last switch
          options[switch] = value
          switch = nil
        else
          rest << value
        end
      end
    end
    
    [options, rest]
  end
end