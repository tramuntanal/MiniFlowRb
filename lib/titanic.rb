#
# With data from the Housing Values in Suburbs of Boston,
# executes the model from mini_flow/examples/boston_model
#
require_relative 'mini_flow'

case ARGV[0]
when '--help'
  puts <<EOHELP
Runs MiniFlow's example model for the Titanic Disaster data.
Usage: ruby titanic.rb [options] [epochs]
  epochs: defaults to 10. The epochs that the model will be iterated.
Options:
  --layers shows the model architecture.
  --help shows this help message.

EOHELP
  exit
when '--layers'
  puts "Example architecture to fit againts the Titanic dataset:"
  puts MiniFlow::Examples::TitanicModel::LAYERS
  exit
when '--summary'
  titanic= MiniFlow::Examples.load_titanic
  puts "Columns for the Titanic Disaster dataset:"
  set_name= ARGV[1] || :data
  puts "for the __#{set_name}__ set"
  puts titanic[set_name.to_sym].summary
  exit
end

epochs= ARGV[0] || 10

model= MiniFlow::Examples::TitanicModel.new
model.fit(epochs: epochs.to_i)
model.print_graph_arch

titanic= MiniFlow::Examples.load_titanic
x_df= titanic[:train]
results= []
x_df.each_row_with_index {|row, idx|
  rs= model.predict(row.to_a).first
  results << rs
}
puts results
