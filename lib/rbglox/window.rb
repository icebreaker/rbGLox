# Semi-abstract Window class
class RBGLox::Window
  include Glfw
  include Gl
  include Glu
  include Glut

  attr_accessor :title, :width, :height, :multisample, :vsync, :watch

  # Constructor
  def initialize
    @title = 'rbGLox'
    @width = 640
    @height= 480
    @multisample = 0
    @vsync = 0
    @watch = nil
  end

  # Closes the currently active open window
  def close
    glfwCloseWindow
  end

  # Returns TRUE if the given key is PRESSED, otherwise FALSE
  def key?(key)
    glfwGetKey(key) == GLFW_PRESS
  end

  # Returns TRUE if the given mouse button is PRESSED, otherwise FALSE
  def mouse?(button = GLFW_MOUSE_BUTTON_LEFT)
    glfwGetMouseButton(button) == GLFW_PRESS
  end

  # Return TRUE if the left mouse button is PRESSED, otherwise FALSE
  def mouse_left?
    mouse?
  end

  # Return TRUE if the right mouse button is PRESSED, otherwise FALSE
  def mouse_right?
    mouse? GLFW_MOUSE_BUTTON_RIGHT
  end

  # Returns the current mouse position (tuple)
  def mouse_pos?
    glfwGetMousePos
  end

  # Returns the current mouse wheel delta position
  def mouse_wheel?
    glfwGetMouseWheel
  end

  # Returns the current tick count
  def time
    glfwGetTime
  end

  # Opens the window and fires up the event loop
  def exec
    glutInit

    glfwOpenWindowHint GLFW_WINDOW_NO_RESIZE, true
    #glfwOpenWindowHint GLFW_FSAA_SAMPLE, multisample
 
    glfwOpenWindow width, height, 0, 0, 0, 0, 32, 0, GLFW_WINDOW

    glfwSetWindowPos 0, 0
    glfwSetWindowTitle title
    glfwEnable GLFW_KEY_REPEAT
    glfwSwapInterval vsync

    glfwSetWindowSizeCallback lambda { |w, h| resize(w, h) }

    trap('INT') do
      glfwCloseWindow
    end

    unless watch.nil?
      puts "Watching #{watch} for changes ..."
      dw = DirectoryWatcher.new watch, :glob => "**/*", :pre_load => true, :interval => 1
      dw.add_observer do |*args|
        args.each do |event|
          reload event
        end
      end
      dw.start
    end

    glClearColor 0.2, 0.2, 0.2, 1
		glClearDepth 1.0
		
    glEnable GL_DEPTH_TEST
		glDepthFunc GL_LEQUAL 
	
    glShadeModel GL_SMOOTH
    glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST

    glEnable GL_TEXTURE_2D
		glEnable GL_COLOR_MATERIAL
		glEnable GL_NORMALIZE

    puts 'init'
    init

    while true
      break unless glfwGetWindowParam GLFW_OPENED
      break if key? GLFW_KEY_ESC
      
      update

      begin_frame
        draw
      end_frame
    end

    unless watch.nil?
      dw.stop
    end

    shutdown
    puts 'shutdown'
  end

  # User defined initializations
  def init
  end

  # User defined shutdown
  def shutdown
  end

  # User defined window resize, sets up viewport and perspective projection
  def resize(w, h)
    glViewport 0, 0, w, h
	
		glMatrixMode GL_PROJECTION
		glLoadIdentity
	
		gluPerspective 45.0, w.to_f/h.to_f, 0.1, 1000.0
	
		glMatrixMode GL_MODELVIEW
		glLoadIdentity
  end

  # User defined method called when entering a frame
  def begin_frame
    glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
    glLoadIdentity
  end

  # User defined method called when leaving the frame
  def end_frame
    glfwSwapBuffers
  end

  # User defined draw method
  def draw
     raise NotImplementedError
  end

  # User defined update method
  def update
    # empty
  end

  # User defined reload event method
  def reload(event)
    # empty
  end
end
