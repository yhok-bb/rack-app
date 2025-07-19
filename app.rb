class App
  def call(env)
    # raise "Test error" <- ShowExceptionsMiddlewareで捕捉される
    case env["PATH_INFO"]
    when "/hello"
      [200, { "content-type" => "text/html" }, ["<h1>Hello</h1>"]]
    when "/goodbye"
      [200, { "content-type" => "text/html" }, ["<h1>Goodbye</h1>"]] 
    when "/input"
      input = env["rack.input"].read
      [200, { "content-type" => "text/html" }, ["<h1>Input data: '#{input}'</h1>"]]
    else
      [404, { "content-type" => "text/html" }, ["<h1>Not Found</h1>"]]
    end
  end
end