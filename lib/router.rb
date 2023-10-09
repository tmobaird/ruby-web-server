class Router
  def initialize(routes = {})
    @routes = routes
  end

  def call(path)
    if @routes.key?(path)
      @routes[path].call
    end
  end
end
