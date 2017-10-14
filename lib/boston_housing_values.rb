#
# With data from the Housing Values in Suburbs of Boston,
# executes the model from mini_flow/examples/boston_model
#
require_relative 'mini_flow'

case ARGV[0]
when '--help'
  puts <<EOHELP
Runs MiniFlow's example model for the Housing Values in Suburbs of Boston data.
Usage: ruby boston_housing_values.rb [options] [epochs]
  epochs: defaults to 10. The epochs that the model will be iterated.
Options:
  --layers shows the model architecture.
  --help shows this help message.

EOHELP
  exit
when '--layers'
  puts "Example architecture to fit againts the Boston dataset:"
  puts MiniFlow::Examples::BostonModel::LAYERS
  exit
when '--summary'
  boston= MiniFlow::Examples.load_boston
  puts "Columns for the Housing Values in Suburbs of Boston dataset:"
  puts boston[:data].summary
end

epochs= ARGV[0] || 10

model= MiniFlow::Examples::BostonModel.new
model.fit(epochs: epochs.to_i)
model.print_graph_arch

boston= MiniFlow::Examples.load_boston
x_df= boston[:data]
y_df= boston[:target]
x_df.each_row_with_index {|row, idx|
  rs= model.predict(row.to_a).first
  dev= rs - y_df[idx]
  puts "Prediction #{idx}: #{rs}, dev: #{dev}"
}
