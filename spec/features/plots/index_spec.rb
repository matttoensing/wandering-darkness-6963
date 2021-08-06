require 'rails_helper'

RSpec.describe 'plots index page' do
  describe 'contents' do
    it 'displays plot number as well as the names of the plants in the plot' do
      garden = Garden.create!(name: 'Eldo Community Garden', organic: true)
      plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'North')
      plant1 = Plant.create!(name: 'Tomato', description: 'Tasty', days_to_harvest: 95)
      plant2 = Plant.create!(name: 'Raspberry', description: 'Delicious', days_to_harvest: 70)
      plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'East')
      plant3 = Plant.create!(name: 'Cherry', description: 'Awesome Fruit and Flowers', days_to_harvest: 80)
      plant4 = Plant.create!(name: 'Kale', description: 'Easy to Grow', days_to_harvest: 45)
      plot_plant1 = PlotPlant.create!(plot: plot1, plant: plant1)
      plot_plant1 = PlotPlant.create!(plot: plot1, plant: plant2)
      plot_plant1 = PlotPlant.create!(plot: plot2, plant: plant3)

      visit '/plots'

      expect(page).to_not have_content(plant4.name)
      expect(page).to have_content(plot1.number)
      expect(page).to have_content(plot2.number)
      expect(page).to have_content(plant1.name)
      expect(page).to have_content(plant2.name)
      expect(page).to have_content(plant3.name)

#       User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see names of all that plot's plants

    end
  end
end
