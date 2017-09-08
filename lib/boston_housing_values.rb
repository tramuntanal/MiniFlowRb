#
# With data from the Housing Values in Suburbs of Boston,
# executes the model from mini_flow/examples/boston_model
#
require_relative 'mini_flow'

epochs= ARGV[0] || 10

model= MiniFlow::Examples::BostonModel.new
model.run(epochs: epochs.to_i)