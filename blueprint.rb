require "base64"
require "zlib"
require "json"

# Taken directly from https://gist.github.com/1st8/17e1d942c376e82c6d63e0ac5291a85c
module Blueprint
  extend self
  def hash_to_blueprint(data)
    "0#{Base64.encode64(Zlib.deflate(data.to_json, Zlib::BEST_COMPRESSION))}".delete("\n")
  end

  def blueprint_to_hash(blueprint)
    JSON.parse(Zlib.inflate(Base64.decode64(blueprint.slice(1..-1))))
  end
end
