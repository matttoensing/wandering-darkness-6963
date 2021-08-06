class Garden < ApplicationRecord
  has_many :plots

  def plant_names_less_than_hundred
    self.plots.joins(:plants).select(:plants).distinct.where('days_to_harvest <= ?', 100).pluck(:name)
  end
end
