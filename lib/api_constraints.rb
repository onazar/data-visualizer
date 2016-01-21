class ApiConstraints
  def initialize(options = nil)
    if options
      @version = options[:version]
      @default = options[:default]
    end
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("api.data-visualizer.v#{@version}")
  end
end