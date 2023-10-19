require_relative "exceptions"

class Router
  def initialize(routes = {})
    @routes = routes
  end

  def call(path, request)
    if route?(path)
      full_route = route(path)
      update_params_from_path(request, path, full_route)

      route = full_route.last
      method = action_key(request)
      handler = route[method]

      if !handler.is_a?(Hash) && !handler.is_a?(Proc)
        raise Exceptions::RouteNotFoundError, "Route #{method} #{path} does not exist"
      end

      if handler[:action].is_a? Proc
        handler[:action].call
      else
        action_name = handler[:action]
        action = Action.new(request)

        raise StandardError, "Action #{@routes[path]} does not exist" unless action.respond_to? action_name

        action.send(action_name)
      end
    else
      raise Exceptions::RouteNotFoundError, "Route #{path} not found"
    end
  end

  def update_params_from_path(request, path, route)
    params = {}
    path_parts = path_parts(path)
    route_parts = path_parts(route.first)

    path_parts.each_with_index do |part, i|
      if route_parts[i][0] == ":"
        key = route_parts[i].split(":").last
        value = part
        params[key] = value
      end
    end

    request.params = request.params.merge(params)
  end

  def route?(path)
    route(path).present?
  end

  def route(path)
    path_parts = path_parts(path)

    @routes.find do |name, value|
      parts = path_parts(name)
      next if path_parts.count != parts.count
      match = true
      parts.each_with_index do |part, i|
        if part[0] != ":"
          match = part == path_parts[i]
        end
      end
      match
    end
  end

  private

  def action_key(request)
    request.method.downcase.to_sym
  end

  def path_parts(path)
    path.split("/").reject { |p| p == "" }
  end
end
