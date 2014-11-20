# GLSL Shader Class
class RBGLox::Shader < RBGLox::Resource
  include Gl

  attr_reader :filename, :vertex, :fragment, :uniforms

  # Constructor
  def initialize(filename)
    @filename = filename
    @id = glCreateProgram

		@vertex = glCreateShader GL_VERTEX_SHADER
    glAttachShader id, vertex

    @fragment = glCreateShader GL_FRAGMENT_SHADER
    glAttachShader id, fragment

    @uniforms = []

    reload
  end

  # Set internal GLSL uniforms
  def []=(name, value)
    loc = glGetUniformLocation id, name
    if value.is_a? Float
      glUniform1f loc, value
    elsif value.is_a? Integer
      glUniform1i loc, value
    elsif value.is_a? Array
      l = value.size
    	if l == 2
				glUniform2fv loc, value
			elsif l == 3
				glUniform3fv loc, value
			elsif l == 4
				glUniform4fv loc, value
      end
    else
      raise TypeError.new('Uniform type not supported')
    end
  end

  # Bind the Shader
  def bind
    glUseProgram id
    
    uniforms.each do |k, v|
      self[k] = v
    end
  end

  # Release the Shader
  def release
    glUseProgram 0
  end

  # Reload the Shader
  def reload
    content = File.read filename
    vert, frag, unis = parse content

    glShaderSource vertex, vert
    glCompileShader vertex
    log = glGetShaderInfoLog vertex
    puts log

    return if log =~ /error/i

    glShaderSource fragment, frag
    glCompileShader fragment
    log = glGetShaderInfoLog fragment
    puts log

    return if log =~ /error/i

		glLinkProgram id
    log = glGetProgramInfoLog id
    puts log

    return if log =~ /error/i

    @uniforms = unis
  end

  # Free the Shader
  def free
    glDetachShader id, vertex
    glDeleteShader vertex

    glDetachShader id, fragment
    glDeleteShader fragment

    glDeleteProgram id
  end

  protected

  # Parse the Shader file and extract the Vertex and Fragment shaders
  def parse(content)
    source = []

    matches = content.scan(/\[(vertex|fragment|uniforms)\]\s?(.*?\s?)\s?\[end\]/m)
    matches.each do |m|
      if ["vertex", "fragment"].include?(m[0])
        source.push(m[1])
      elsif m[0] == "uniforms"
        source.push(YAML.load(m[1]))
      end
    end
    
    source
  end

end
