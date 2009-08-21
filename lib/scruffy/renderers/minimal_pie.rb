module Scruffy::Renderers
  # ===Scruffy::Renderers::Base
  #
  # Author:: A.J. Ostman
  # Date:: August 14th, 2006
  #
  # Provides a more appropriate rendering for Pie Charts.
  # Does not show grid or Data markers, but does add Pie Value Markers.
  class MinimalPie < Base

    def initialize
      self.components = []
      self.components << Scruffy::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])
      self.components << Scruffy::Components::Viewport.new(:graph_viewport, :position => [0, 0], :size => [100, 100]) do |view|
        view << Scruffy::Components::Graphs.new(:graphs, :position => [20, 0], :size => [60, 60])
      end
      self.components << Scruffy::Components::Legend.new(:legend, :position => [10, 58], :size => [80, 40], :vertical_legend => true)
    end

    # Renders the graph and all components.
    def render(options = {})
      # Set the default size to a more suitable one
      options[:size] ||= (options[:height] ? [(options[:height] * 0.55).to_i, options.delete(:height)] : [385, 700])
      super
    end

  end

end
