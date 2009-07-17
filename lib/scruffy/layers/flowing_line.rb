module Scruffy::Layers
  # ==Scruffy::Layers::FlowingLine
  #
  # Author:: Brasten Sager
  # Date:: August 7th, 2006
  #
  # Flowing Line graph.
  class FlowingLine < Base

    # Renders line graph.
    #
    # Options:
    # See initialize()
    def draw(svg, coords, options={})

      # Include options provided when the object was created
      options.merge!(@options)

      stroke_width = (options[:relativestroke]) ? relative(options[:stroke_width]) : options[:stroke_width]
      style = (options[:style]) ? options[:style] : ''

      if options[:shadow]
        svg.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
          svg.polyline( :points => stringify_coords(coords).join(' '), :fill => 'transparent',
                        :stroke => 'black', 'stroke-width' => stroke_width,
                        :style => 'fill-opacity: 0; stroke-opacity: 0.35' )
        }
      end


      svg.polyline( :points => stringify_coords(coords).join(' '), :fill => 'none', :stroke => @color.to_s,
                    'stroke-width' => stroke_width, :style => style  )
    end
  end
end
