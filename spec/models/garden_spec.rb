require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    describe '#plants_less_than_hundred' do
      it 'returns a unique collection of plants that have less than 100 days to harvest' do
        garden = Garden.create!(name: 'Eldo Community Garden', organic: true)
        plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'North')
        plant1 = Plant.create!(name: 'Tomato', description: 'Tasty', days_to_harvest: 115)
        plant2 = Plant.create!(name: 'Raspberry', description: 'Delicious', days_to_harvest: 70)
        plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'East')
        plant3 = Plant.create!(name: 'Cherry', description: 'Awesome Fruit and Flowers', days_to_harvest: 80)
        plant4 = Plant.create!(name: 'Chard', description: 'Perfect for any Salad', days_to_harvest: 124)
        plot_plant1 = PlotPlant.create!(plot: plot1, plant: plant1)
        plot_plant2 = PlotPlant.create!(plot: plot1, plant: plant2)
        plot_plant3 = PlotPlant.create!(plot: plot2, plant: plant2)
        plot_plant4 = PlotPlant.create!(plot: plot2, plant: plant3)
        plot_plant5 = PlotPlant.create!(plot: plot2, plant: plant4)

        expected = [plant2.name, plant3.name]

        expect(garden.plants_less_than_hundred).to eq(expected.sort)
      end
    end
  end
end
