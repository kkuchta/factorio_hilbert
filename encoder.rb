require "./blueprint"
input = ARGF.read
input_hash = JSON.parse(input)

# echo "{blueprint: ...}" | encoder
# ^ outputs a blueprint string from the given json
puts Blueprint.hash_to_blueprint(input_hash)
