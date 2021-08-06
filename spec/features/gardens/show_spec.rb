require 'rails_helper'

RSpec.describe 'garden show page' do
  before(:each) do
    @garden = Garden.create!(name: 'Eldo Community Garden', organic: true)
    @plot1 = @garden.plots.create!(number: 1, size: 'Large', direction: 'North')
    @plant1 = Plant.create!(name: 'Tomato', description: 'Tasty', days_to_harvest: 115)
    @plant2 = Plant.create!(name: 'Raspberry', description: 'Delicious', days_to_harvest: 70)
    @plot2 = @garden.plots.create!(number: 2, size: 'Medium', direction: 'East')
    @plant3 = Plant.create!(name: 'Cherry', description: 'Awesome Fruit and Flowers', days_to_harvest: 80)
    @plant4 = Plant.create!(name: 'Chard', description: 'Perfect for any Salad', days_to_harvest: 124)
    plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    plot_plant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
    plot_plant3 = PlotPlant.create!(plot: @plot2, plant: @plant2)
    plot_plant4 = PlotPlant.create!(plot: @plot2, plant: @plant3)
    plot_plant5 = PlotPlant.create!(plot: @plot2, plant: @plant4)
  end

  describe 'content' do
    it 'visitor sees a unique list of plants that are included in that gardens plots which take less than 100 days to harvest' do
      visit garden_path(@garden.id)

      expect(page).to_not have_content(@plant1.name)
      expect(page).to_not have_content(@plant4.name)
      expect(page).to have_content(@plant2.name, count: 1)
      expect(page).to have_content(@plant3.name)
    end
  end

  describe 'plants sorted on page' do
    it 'visitor sees plants sorted by the number of plants that appear in any of that gardens plots from most to least' do
      visit garden_path(@garden.id)

      expect(@plant2.name).to appear_before(@plant3.name)
# As a visitor
# When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)

    end
  end
end
