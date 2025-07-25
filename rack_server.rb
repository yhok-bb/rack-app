require 'socket'
require 'uri'
require 'stringio'
require_relative 'SimpleMiddleware'
require_relative 'LoggerMiddleware'
require_relative 'ShowExceptionsMiddleware'
require_relative 'StaticMiddleware'

app_file = File.basename(ARGV[0], '.rb')
require_relative "./#{app_file}"

app_class = Object.const_get(File.basename(app_file, '.rb').capitalize)
app = ShowExceptionsMiddleware.new(
  LoggerMiddleware.new(
    StaticMiddleware.new(
      SimpleMiddleware.new(
        app_class.new
      )
    )
  )
)

server = TCPServer.new(3000)

puts "サーバー起動中！！！！"

loop do
  socket = server.accept
  request = socket.gets

  puts "ソケット作成、リクエスト受付！！！"
  if request.nil?
    socket.close
    puts "ソケット緊急終了！！！"
    next
  end

  env = {}
  env["REQUEST_METHOD"], path_info, protocol = request.split
  env["SERVER_PROTOCOL"] = protocol.strip

  uri = URI.parse(path_info)
  env["PATH_INFO"] = uri.path
  env["QUERY_STRING"] = uri.query || ""  # nilの場合は空文字列
  env["SERVER_NAME"] = "localhost"
  env["rack.url_scheme"] = "http"
  env["rack.errors"] = $stderr
  env["rack.input"] = StringIO.new("") # 空のIOオブジェクト
  puts env
  status, headers, body = app.call(env)
  reason = {
    200 => "OK",
    404 => "Not Found"
  }[status] || "OK"

  header_lines = headers.map { |k, v| "#{k}: #{v}" }.join("\r\n")
  res = "HTTP/1.1 #{status} #{reason}\r\n" \
        "#{header_lines}\r\n" \
        "Content-Length: #{body.join.bytesize}\r\n" \
        "\r\n" \
        "#{body.join}"

  socket.print res
  socket.close
  puts "サーバー終了！！！！"
end