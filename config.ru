require_relative 'app'
require_relative 'ShowExceptionsMiddleware'
require_relative 'LoggerMiddleware'
require_relative 'StaticMiddleware'
require_relative 'SimpleMiddleware'

@middleware_stack = []

def use(klass)
  @middleware_stack << klass
end

# 再帰
def run(app)
  @middleware_stack.reverse.each do |klass|
    app = klass.new(app)
  end
  app
end

use ShowExceptionsMiddleware
use LoggerMiddleware
use StaticMiddleware
use SimpleMiddleware

run App.new
