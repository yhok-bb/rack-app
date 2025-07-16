require 'socket'
require_relative "./app"

app = App.new
server = TCPServer.new(3000)

puts "サーバー起動中！！！！"

loop do
  socket = server.accept
  request = socket.gets
  env = {}
  env["REQUEST_METHOD"], env["PATH_INFO"], _ = request.split
  status, headers, body = app.call(env)
  reason = {
    200 => "OK",
    404 => "Not Found"
  }[status] || "OK"

  header_lines = headers.map { |k, v| "#{k}: #{v}" }.join("\r\n")
  res = "HTTP/1.1 #{status} #{reason}\r\n" \
        "#{header_lines}\r\n" \
        "Content-Length: #{body.bytesize}\r\n" \
        "\r\n" \
        "#{body.join}"

  socket.print res
  socket.close
end