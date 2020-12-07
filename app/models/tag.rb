class Tag < ApplicationRecord
  belongs_to :invite, optional: true
  belongs_to :post, optional: true
end
