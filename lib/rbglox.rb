require 'gl'
require 'glu'
require 'glut'
require 'glfw'
require 'directory_watcher'

module RBGLox
  class RBGLoxException < StandardError; end
end

require 'rbglox/version'
require 'rbglox/window'
require 'rbglox/resource'
require 'rbglox/texture'
require 'rbglox/shader'
require 'rbglox/mesh'
require 'rbglox/meshquad'
require 'rbglox/meshcube'
require 'rbglox/app'

class ShaderApp < RBGLox::App
  attr_accessor :model

  def init
    @textures = []
    (1..4).each do |i|
      filename = File.join watch, "texture#{i}.tga"
      @textures << RBGLox::Texture.new(filename) if File.exists? filename
    end
    
    @shader = RBGLox::Shader.new File.join watch, "shader.glsl"

    @z = -6.0
    if model == 'quad'
      @model = RBGLox::MeshQuad.new
    elsif ['cube', 'box'].include? model
      @model = RBGLox::MeshCube.new
    else
      @model = nil
      @z = -30.0
    end

    @lastX = 0
    @lastY = 0
    @lastM = 0

    @rotX = 0.0
    @rotY = 0.0
    @rotZ = 0.0
  end

  def update
    currM = mouse_wheel?

    if currM != 0
      @z -= (@lastM - currM)
      @lastM = currM
    end

    if mouse_left?
      currX, currY = mouse_pos?

      if @lastX > 0 and @lastY > 0
        @rotX += (currY - @lastY)
        @rotY += (currX - @lastX)
      end

      @lastX = currX
      @lastY = currY
    else
      @lastX = 0
      @lastY = 0
    end

  end

  def draw
    glTranslatef(0,0, @z)
    glRotatef(@rotX, 1.0, 0.0, 0.0)
    glRotatef(@rotY, 0.0, 1.0, 0.0)
    glRotatef(@rotZ, 0.0, 0.0, 1.0)

    @textures.each_with_index do |texture, i|
      texture.bind i
    end
    
    @shader.bind
    @shader['time'] = time.to_f
    
    if @model.nil?
      glutSolidTeapot(8.0)
    else
      @model.draw
    end

    @shader.release

    @textures.each_with_index do |texture, i|
      texture.release i
    end
  end

  def shutdown
    @textures.each do |texture|
      texture.free
    end
    @shader.free
    @model.free unless @model.nil?
  end

  def reload(event)
    if event.type == :modified
      puts "reloading #{event.path} ..."
      if event.path =~ /\.glsl$/i
        @shader.reload
      elsif event.path =~ /\.tga$/i
        @textures.each_with_index do |texture, i|
          if texture.filename == event.path
            texture.reload i
            break
          end
        end
      end
    end
  end
end
