#!/usr/bin/ruby -w

# This is a very simple SVDRP client that just sends commands to the server
# from the command line
#
# Copyright 2006 Toni Leino ( toni@leino.net | http://github.com/Frodotus )
#

require 'svdrp'

		svdrp = SVDRP.new
		puts svdrp.connect
        if svdrp.connected?
          puts svdrp.channel
        end