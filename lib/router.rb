class Router
  def initialize(routes = {})
    @routes = routes
  end

  def call(path, request)
    if @routes.key?(path)
      if @routes[path].is_a?(String)
        action = Action.new(request)

        raise StandardError, "Action #{@routes[path]} does not exist" unless action.respond_to? @routes[path]

        action.send(@routes[path])
      else
        @routes[path].call
      end
    end
  end
end
