class Garden < ApplicationRecord
  has_many :plots

# my original query for user story #3 before adding the order part, looks like I am ot able to use distinct with ordering

  # def plant_names_less_than_hundred
  #   self.plots.joins(:plants).select(:plants).distinct.where('days_to_harvest <= ?', 100).pluck(:name)
  # end

  def plant_names_less_than_hundred
    self.plots.joins(:plants).group('plants.name').select('plants.*, COUNT(plants.id)').order(Arel.sql('COUNT(plants.id) DESC')).where('days_to_harvest <= ?', 100).pluck(:name)
  end
end
