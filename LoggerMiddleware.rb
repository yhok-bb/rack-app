class LoggerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "app: #{@app}"
    start_time = Time.now
    status, headers, body = @app.call(env)

    end_time = Time.now
    duration = (end_time - start_time) * 1000
    puts "[#{end_time}] #{env["REQUEST_METHOD"]} #{env["PATH_INFO"] } - #{status} OK (#{duration.round(3)}ms)"

    [status, headers, body]
  end
end