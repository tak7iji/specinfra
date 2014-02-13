module SpecInfra
  module Backend
    class Dockerfile < SpecInfra::Backend::Base
      def initialize
        @lines = []
        ObjectSpace.define_finalizer(self) {
          File.write("Dockerfile", @lines.join("\n"))
        }
      end

      def run_command(cmd, opts={})
        @lines << "RUN #{cmd}"
        CommandResult.new
      end

      def from(base)
        @lines << "FROM #{base}"
      end
      
      def copy_file(from, to)
        @lines << "ADD #{from} #{to}"
      end
    end
  end
end
