class SVDRP

	require 'socket'

	class Channel < Hash
	end

	def initialize( hostname = 'nvdr', port = 2001 )
		@hostname = hostname
		@port = port
	end

	def connect()
		if self.connected?
			raise 'SVDRP Error: Already Connected'
		end

		@socket = TCPSocket::new @hostname, @port
		ret = @socket.gets
		return ret
	end

	def connected?
		return false if @socket.nil?
		begin
 			ret = send_command 'CHAN'
 			if /^250 /.match(ret)
		      ret=true
		    else
  			  ret = false
		    end

		rescue
			ret = false
		end

		return ret
	end

	def disconnect
		return if @socket.nil?
		@socket.puts 'QUIT'
		@socket.close
		@socket = nil
	end

	def channel
		return send_command 'CHAN'
	end

	def channel=(c)
		return send_command 'CHAN '+c.to_s
	end

	def send_command( command )
		if @socket.nil?
			raise "VDR: Not Connected to the Server"
		end

		ret = nil

		begin
			@socket.puts command
			ret = handle_server_response
		rescue Errno::EPIPE
			@socket = nil
			raise 'VDR Error: Broken Pipe (Disconnected)'
		end

		return ret
	end

	def handle_server_response
		return if @socket.nil?

		msg = ''
		reading = true
		while reading
			line = @socket.gets
		    if /^\d{3} /.match(line)
		      reading=false
		    end
			msg += line
		end

		return true if msg.empty?
		return msg
	end

	def build_channel( string )
		return if string.nil? or !string.kind_of? String

		channel = Channel.new
		lines = string.split "\n"
		lines.each do |line|
			channel[ line.gsub(/:.*/, '').downcase ] = line.gsub(/\A[^:]*: /, '')
		end

		return song
	end

	private :send_command
	private :handle_server_response
	private :build_channel

end
