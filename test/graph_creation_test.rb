require 'test/unit'
require 'test_helper'

class SimpleTheme < Scruffy::Themes::Base
  def initialize
    super({
        :background => [:white, :white],
        :marker => :black,
        :colors => %w(blue green red orange yellow purple pink),
        :stroke_color => 'white'
      })
  end
end

$make_png = true
begin
  require 'RMagick'
rescue LoadError
  $make_png = nil
end

class GraphCreationTest < Test::Unit::TestCase
  BASE_DIR = File.dirname(__FILE__)
  WEBSITE_DIR = BASE_DIR + "/../website/images/graphs"

  def test_create_pie
    graph = Scruffy::Graph.new
    graph.title = "Favourite Snacks"
    graph.renderer = Scruffy::Renderers::Pie.new

    graph.add :pie, '', {
      'Apple' => 20,
      'Banana' => 100,
      'Orange' => 70,
      'Taco' => 30
    }

    graph.render :to => "#{WEBSITE_DIR}/pie_test.svg"
    graph.render :width => 400, :to => "#{WEBSITE_DIR}/pie_test.png", :as => 'png' if $make_png
  end
  
  def test_create_line
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "#{WEBSITE_DIR}/line_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/line_test.png", :as => 'png' if $make_png
  end

  
  def test_create_bar
    graph = Scruffy::Graph.new
    graph.title = "Sample Bar Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.add :bar, 'Example', [20, 100, 70, 30, 106]
    graph.render :to => "#{WEBSITE_DIR}/bar_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/bar_test.png", :as => 'png' if $make_png
  end
  
  def test_split
    graph = Scruffy::Graph.new
    graph.title = "Long-term Comparisons"
    graph.value_formatter = Scruffy::Formatters::Currency.new(:special_negatives => true, :negative_color => '#ff7777')
    graph.renderer = Scruffy::Renderers::Split.new(:split_label => 'Northeastern (Top) / Central (Bottom)')

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106, 203, 100, 50, 203, 289, 20], :category => :top    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26, 30, 106, 203, 100, 50, 39], :category => :top
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203, 70, 20, 102, 201, 26, 130], :category => :bottom
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70, -10, -20, 50, 92, -21, 19], :categories => [:top, :bottom]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56, 92, 84, 82, 100, 39, 120], :categories => [:top, :bottom]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    
    graph.render :to => "#{WEBSITE_DIR}/split_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/split_test.png", :as => 'png' if $make_png
  end
  
  def test_stacking
    graph = Scruffy::Graph.new
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :stacked do |stacked|
      stacked.add :bar, 'Jack', [30, 60, 49, 29, 100, 120]
      stacked.add :bar, 'Jill', [120, 240, 0, 100, 140, 20]
      stacked.add :bar, 'Hill', [10, 10, 90, 20, 40, 10]
    end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/stacking_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/stacking_test.png", :as => 'png' if $make_png
  end
  
  def test_multi_layered
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Cubed.new

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106], :categories => [:top_left, :bottom_right]    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26], :categories => [:bottom_left, :buttom_right]
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203], :categories => [:bottom_left, :top_right]
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70], :categories => [:top_right, :bottom_left]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56], :categories => [:top_left, :bottom_right]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/multi_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/multi_test.png", :as => 'png' if $make_png
  end
  
  def test_scatter
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :scatter, 'Stephanie', {0 => 0, 1 => 1, 2 => 4, 3 => 9, 4 => 8, 5 => 10, 6 => 12, 7 => 3, 8 => 13}    
    graph.add :line, 'Artiom', {-3 => 2, 1.5 => 6, 2 => 4.5, 15 => -4}, :dots => true   
    graph.add :scatter, 'Sam', [[-3,15], [1.5,18], [2,9], [15,6]]   
    graph.render :to => "#{WEBSITE_DIR}/scatter_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/scatter_test.png", :as => 'png' if $make_png
  end
  
  def test_scatter_by_date
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.key_formatter = Scruffy::Formatters::Date.new("%H:%M")
    h = {}
    start = Time.local(2009, 1, 20, 12, 0, 0)
    30.times{|i| h[start + 60*i] = i*i}
    
    graph.add :scatter, 'DNI', h
    graph.render :to => "#{WEBSITE_DIR}/scatter_date_test.svg", :calculate_markers => true
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/scatter_date_test.png", :as => 'png' if $make_png
  end
end
