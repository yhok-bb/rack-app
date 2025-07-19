class StaticMiddleware
  def initialize(app, root = "public")
    @app = app
    @root = root
  end

  def call(env)
    puts "app: #{@app}"
    path = File.join(@root, env["PATH_INFO"])

    if File.file?(path) && File.readable?(path)
      res = [
              200,
              { "content-type" => ext_type(File.extname(path)) },
              [File.read(path)]
            ]
      return res
    end

    @app.call(env)
  end

  private

  def ext_type(ext)
    case ext
    when ".css"
      "text/css"
    when ".js"
      "application/javascript"
    when ".png"
      "image/png"
    when ".html"
      "text/html"
    else
      "application/octet-stream"
    end
  end
end