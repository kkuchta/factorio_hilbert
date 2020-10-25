require "./blueprint"
input = ARGF.read

# echo "abc123==" | ruby decoder.rb
# ^ outputs a json-representation of the given blueprint string
puts Blueprint.blueprint_to_hash(input).to_json
