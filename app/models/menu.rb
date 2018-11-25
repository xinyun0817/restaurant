# == Schema Information
#
# Table name: menus
#
#  id          :bigint(8)        not null, primary key
#  item        :string(255)      not null
#  price       :decimal(5, 2)    not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)        not null
#  position    :integer          default(0)
#

class Menu < ApplicationRecord
    validates :item, :price, :category_id, presence: true
    validates :item, uniqueness: true
    validates :price, numericality: { greater_than: 0 }
    
    belongs_to :category
    has_many :order_items
    #has_and_belongs_to_many :categories
    
    has_one_attached :photo

end
