rbGLox
======
rbGLox is a small wrapper over the ruby-opengl, ruby-glfw family by abstracting 
and providing some high-level interfaces for things like "Textures",
"GLSL Shaders", basic "Geometry" and others.

It's ideal for rapid prototyping new and interesting ideas.

rbGLox is the sister project of [pyGLox](http://github.com/icebreaker/pyGLox).

Dependencies
------------
* [ruby-opengl](https://rubygems.org/gems/ruby-opengl)
* [ruby-glfw](https://rubygems.org/gems/ruby-glfw)
* [directory-watcher](https://rubygems.org/gems/directory_watcher)

Getting Started
---------------

### Install

	gem install rbglox

### Library

Using rbGLox as a library is a very easy :)

	```ruby
	require 'rbglox'
	class DemoApp < RBGLox::App
  		def init
    		@texture = RBGLox::Texture.new 'mosaic.tga'
    		@r = 0.0 
    		@cube = RBGLox::MeshCube.new
  		end
  		def update
  			@r += 0.1
  		end
	  	def draw
    		glTranslatef 0.0,0.0,-6.0
    		glRotatef @r, 1.0, 1.0, 1.0
    		
    		@texture.bind
	    	@cube.draw
	  	  	@texture.release
  	  	end
	 	def shutdown
    		@texture.free
    		@cube.free
  		end 
	end
	```
	
Now let's fire this up :)

	```ruby
	DemoApp.new do |app|
  		app.title = 'DemoApp'
  		app.exec
	end
	```
	
Additional methods you can override:

	```ruby
	resize(h, w)
	begin_frame
	end_frame
	reload(event)
	```
	
#### Semi-automatic resource re-loading

	```ruby
	DemoApp.new do |app|
		app.watch = 'data/'
  		app.title = 'DemoApp'
  		app.exec
	end
	```
If the `watch` variable is not `nil` then the given directory will be watched
for any changes. (i.e file modified, file created, etc)

Every time a change is detected, the `reload(event)` method is called and you can
reload your resources.

The included `RBGLox::Texture` and `RBGLox::Shader` classes have a `reload` method 
which facilitates this as illustrated in the example below.

	```ruby
	...
	def reload(event)
		if event.type == :modified
			texture1.reload if event.path =~ /myawesometexture.tga$/
			shader.reload if event.path =~ /myshader.glsl$/
			...
		end
		...
	end
	...
	```
	
### Executable

It is also possible to use rbGLox as a cheap & rudimentary "GLSL" shader editor.

In order to create a new project do the following:

	mkdir glsl-demo
	cd glsl-demo
	rbglox --init
	
This will create an empty project with one shader and one texture.

To launch "editor" just type `rbglox` in the current directory and there you go.

#### Watcher

All the resources in the current directory are "watched" for changes and will be
reloaded automatically when a change is detected.

So, if you edit the shaders or the textures they will be reloaded for you without
restarting the "editor".

#### Shaders

The shader file has the following format:

	[vertex]
	...
	[end]
	
	[fragment]
	...
	[end]
	
	[uniforms]
	...
	[end]
	
Please consult the generated `default shader` when you start a "new project" for 
more details.

The shader must be named `shader.glsl` in order to be used and loaded.


#### Textures

Only textures in the TGA format are supported and they are going to be loaded
in alphabetical order. If there are more than 4 textures, only the first 4
will be loaded and assigned to the first 4 available texture units.

The textures must be named in the following format: `textureN.tga` where `N`
is a number ranging from 1 to 4.

#### Models (a.k.a Meshes)

You can choose between a Quad, a Cube (a.k.a Box) and a Teapot. The default is
the Teapot.

	rbglox --model teapot
	
#### Controls

* Hold down the left mouse button and move the mouse in order to rotate the model.
* Use the mouse wheel to zoom in / zoom out the model.

rbMedia
-------
The bundled texture is from [lovetextures.com](http://lovetextures.com) .

Contribute
----------
* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.
* Do **not** bump the version number.

License
-------
Copyright (c) 2011, Mihail Szabolcs

rbGLox is provided as-is under the **MIT** license. For more information 
see *LICENSE* .
