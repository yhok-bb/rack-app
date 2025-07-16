class App
  def call(env)
    _    = env["REQUEST_METHOD"]
    path = env["PATH_INFO"]
    case path
    when "/hello"
      [200, { "Content-Type" => "text/html" }, ["<h1>Hello</h1>"]]
    when "/goodbye"
      [200, { "Content-Type" => "text/html" }, ["<h1>Goodbye</h1>"]] 
    else
      [404, { "Content-Type" => "text/html" }, ["<h1>Not Found</h1>"]]
    end
  end
end