class Garden < ApplicationRecord
  has_many :plots

  def plant_names_less_than_hundred
    self.plots.joins(:plants).select(:plants).distinct.where('days_to_harvest < ?', 100).pluck(:name)
  end

# my query for the extension, I wasn't super psyched on it so I decided to just use my original query above, I would like some feedback on htis query below if possible though!

  # def plant_names_less_than_hundred
  #   plots.joins(:plants).group('plants.name').select('plants.*, COUNT(plants.id)').order(Arel.sql('COUNT(plants.id) DESC')).where('days_to_harvest <= ?', 100).pluck(:name)
  # end
end
