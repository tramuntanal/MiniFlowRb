#
# With data from the Housing Values in Suburbs of Boston,
# executes the model from mini_flow/examples/boston_model
#
require_relative 'mini_flow'

if ARGV[0] == '--help'
  puts <<EOHELP
Runs MiniFlow's example model for the Housing Values in Suburbs of Boston data.
Usage: ruby boston_housing_values.rb [options] [epochs]
  epochs: defaults to 10. The epochs that the model will be iterated.
Options:
  --layers shows the model architecture.
  --help shows this help message.

EOHELP
  exit
elsif ARGV[0] == '--layers'
  puts "Example architecture to fit againts the Boston dataset:"
  puts MiniFlow::Examples::BostonModel::LAYERS
  exit
end

epochs= ARGV[0] || 10

model= MiniFlow::Examples::BostonModel.new
model.fit(epochs: epochs.to_i)
rs= model.predict([0.00632,18,2.31,0,0.538,6.575,65.2,4.09,1,296,15.3,396.9,4.98])

puts "Prediction: #{rs}"