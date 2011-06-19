Kernel.load './lib/rbglox/version.rb'

Gem::Specification.new 'rbglox', RBGLox::VERSION do |s|
  s.rubyforge_project = 'rbglox'
  s.authors           = ['Mihail Szabolcs']
  s.email             = ['szaby@szabster.net']
  s.description       = 'rbGLox is a small wrapper over the ruby-opengl, ruby-glfw.'
  s.homepage          = 'http://github.com/icebreaker/rbglox'
  s.rdoc_options      = ["--charset=UTF-8"]
  s.extra_rdoc_files  = %w[README.md LICENSE]
  s.require_paths     = ['lib']
  s.files             = Dir.glob('{lib,res}/**/*') + %w(README.md LICENSE)
  s.test_files        = Dir.glob('test/**/*')
  s.executables       = ['rbglox']
  s.add_runtime_dependency('ruby-opengl', ">= 0.60.1")
  s.add_runtime_dependency('ruby-glfw', ">= 0.9.1")
  s.add_runtime_dependency('directory_watcher', ">= 1.4.0")
  #s.add_development_dependency('yourgem', ">= 1.0.0")
  s.summary           = 'rbGLox is a small wrapper over the ruby-opengl, ruby-glfw family by abstracting and providing some high-level interfaces for things like "Textures", "GLSL Shaders", basic "Geometry" and others.'
end
