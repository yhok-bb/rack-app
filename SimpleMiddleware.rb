class SimpleMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "before"

    status, headers, body = @app.call(env)

    puts "after"

    [status, headers, body]
  end
end