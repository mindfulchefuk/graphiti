RSpec.shared_context 'resource testing' do |parameter|
  let(:resource)     { described_class.new }
  let(:params)       { {} }

  class TestRunner < JsonapiCompliable::Runner
    def current_user
      nil
    end
  end

  # If you need to set context:
  #
  # JsonapiCompliable.with_context my_context, {} do
  #   render
  # end
  def render(runtime_options = {})
    ctx = TestRunner.new(resource, params)
    proxy = defined?(base_scope) ? ctx.proxy(base_scope) : ctx.proxy
    json = ctx.render_jsonapi(proxy, runtime_options)
    response.body = json
    json
  end

  def records
    ctx = TestRunner.new(resource, params)
    ctx.proxy(base_scope).to_a
  end

  def response
    @response ||= OpenStruct.new
  end
end
