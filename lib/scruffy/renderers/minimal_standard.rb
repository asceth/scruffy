module Scruffy::Renderers
  class MinimalStandard < Empty

    def define_layout
      super do |components|
        components << Scruffy::Components::Viewport.new(:view, :position => [0, 0], :size => [100, 100]) do |graph|

          graph << Scruffy::Components::ValueMarkers.new(:values, :position => [0, 4], :size => [4, 88])

          graph << Scruffy::Components::Grid.new(:grid, :position => [8, 4], :size => [84, 88])
          graph << Scruffy::Components::Graphs.new(:graphs, :position => [8, 4], :size => [84, 88])

          graph << Scruffy::Components::ValueMarkers.new(:values, :position => [94, 4], :size => [4, 88])

          graph << Scruffy::Components::DataMarkers.new(:labels, :position => [8, 90], :size => [84, 6])
        end
      end
    end

    protected
      def hide_values
        super
        component(:view).position[0] = -10
        component(:view).size[0] = 100
      end

      def labels
        [component(:view).component(:labels)]
      end

      def values
        [component(:view).component(:values)]
      end

      def grids
        [component(:view).component(:grid)]
      end
  end
end
