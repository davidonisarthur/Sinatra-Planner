# ============== Set Params

before '/*' do
  params = request.body.read
  @params = JSON.parse(params).deep_symbolize_keys unless params.empty?
end

# ============== Set Routes

namespace '/plans' do
  get       ''      do; reply PlansController.new(params).index     end
  post      ''      do; reply PlansController.new(params).create    end
  get       '/:id'  do; reply PlansController.new(params).show      end
  put       '/:id'  do; reply PlansController.new(params).update    end
  delete    '/:id'  do; reply PlansController.new(params).destroy   end
end

# ============== Set Reply

def reply(action)
  status action[:status]
  action[:data]
end
