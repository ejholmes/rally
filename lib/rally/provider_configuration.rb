module Rally
  class ProviderConfiguration < Hashie::Mash
    class << self
      def load(path)
        new YAML.load(ERB.new(File.read(path)).result)
      end
    end
  end
end
