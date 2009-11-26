require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
	s.platform	=	Gem::Platform::RUBY
	s.name			=	"svdrp"
	s.version		=	"0.0.1"
	s.author		=	"Toni Leino"
	s.email			=	"toni@leino.net"
	s.summary		=	"SVDRP protocol implementation"
	s.description   =   "SVDRP protocol implementation for Ruby to control VDR"
	s.files			=	FileList['lib/*.rb', 'examples/*.rb', 'test/*', 'AUTHORS', 'COPYING'].to_a
	s.require_path	=	"lib"
	s.test_files    = Dir.glob('tests/*.rb')
	s.has_rdoc	    =	true
	s.extra_rdoc_files	=	['README']
end

Rake::GemPackageTask.new(spec) do |pkg|
	pkg.need_tar = true
end

task :default => "pkg/#{spec.name}-#{spec.version}.gem" do
	puts 'generated latest version'
end
