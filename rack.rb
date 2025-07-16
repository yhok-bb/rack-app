require 'socket'

class App
  def call(_, path)
    status = ["/hello", "/goodbye"].include?(path) ? "HTTP/1.1 200 OK" : "HTTP/1.1 404 Not Found"
    headers = { "Content-Type" => "text/html" }
    body = case path
         when "/hello"
            "<h1>Hello</h1>"
         when "/goodbye"
            "<h1>Goodbye</h1>"
         else
            "<h1>Not Found</h1>"
         end
    [status, headers, body]
  end
end

app = App.new
server = TCPServer.new(3000)

puts "サーバー起動中！！！！"

loop do
  socket = server.accept
  request = socket.gets
  method, path, _ = request.split
  puts "#{method}, #{path}"

  status, headers, body = app.call(method, path)

  res = "#{status}\r\n" \
        "#{headers}\r\n" \
        "Content-Length: #{body.bytesize}\r\n" \
        "\r\n" \
        "#{body}"

  socket.print res
  socket.close
end