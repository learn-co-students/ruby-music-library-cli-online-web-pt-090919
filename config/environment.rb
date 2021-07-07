require 'bundler'
# tell bundler to read gemfile and require each of those gem into memory
# for this project
Bundler.require

module Concerns
  module Findable
  end
end

require_relative '../lib/concerns/findable'
require_all 'lib'
