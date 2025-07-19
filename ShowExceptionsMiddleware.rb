class ShowExceptionsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "app: #{@app}"
    begin
      @app.call(env)
    rescue => e
      [
        500,
        {"Content-Type" => "text/html"},
        ["<h1>500 Internal Server Error</h1><pre>#{e.message}</pre>"]
      ]
    end
  end
end