require 'rails_helper'

RSpec.describe 'plots index page' do
  before(:each) do
    @garden = Garden.create!(name: 'Eldo Community Garden', organic: true)
    @plot1 = @garden.plots.create!(number: 1, size: 'Large', direction: 'North')
    @plant1 = Plant.create!(name: 'Tomato', description: 'Tasty', days_to_harvest: 95)
    @plant2 = Plant.create!(name: 'Raspberry', description: 'Delicious', days_to_harvest: 70)
    @plot2 = @garden.plots.create!(number: 2, size: 'Medium', direction: 'East')
    @plant3 = Plant.create!(name: 'Cherry', description: 'Awesome Fruit and Flowers', days_to_harvest: 80)
    @plant4 = Plant.create!(name: 'Kale', description: 'Easy to Grow', days_to_harvest: 45)
    plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    plot_plant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
    plot_plant3 = PlotPlant.create!(plot: @plot2, plant: @plant3)
  end

  describe 'contents' do
    it 'displays plot number as well as the names of the plants in the plot' do
      visit plots_path

      expect(page).to_not have_content(@plant4.name)

      within "#plot-#{@plot1.id}" do
        expect(page).to have_content(@plot1.number)
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
      end

      within "#plot-#{@plot2.id}" do
        expect(page).to have_content(@plot2.number)
        expect(page).to have_content(@plant3.name)
      end
    end
  end

  describe 'removing a plant from a plot' do
    it 'next to each plant on page, user seed a link to remove that plant from the plot' do
      visit plots_path

      within "#plot-#{@plot1.id}" do
        expect(page).to have_link('Remove Plant from Plot', count: 2)
      end

      within "#plot-#{@plot2.id}" do
        expect(page).to have_link('Remove Plant from Plot')
      end
    end

    it 'when user clicks the remove button, user is redirected to plots index page where plant is no longer listed' do
      visit plots_path

      expect(page).to have_content(@plant1.name)

      within "#plant-#{@plant1.id}" do
        click_on 'Remove Plant from Plot'
      end
    
      expect(current_path).to eq('/plots')
      expect(page).to_not have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to have_content(@plant3.name)
    end
  end
end
