require 'chef_gen/flavor_base'
require 'chef_gen/snippets'

module ChefGen
  module Flavor
    class ChimpbookInhouse < FlavorBase
      include ChefGen::Snippet::StyleRubocop
      VERSION = '1.0.0'
      class << self
        def description
          'Generate a new cookbook for inhouse use.'
        end

        def code_generator_path(classfile)
          File.expand_path(
            File.join(classfile, '..', '..', '..', '..', 'inhouse', 'code_generator')
          )
        end
      end
    end
  end
end
