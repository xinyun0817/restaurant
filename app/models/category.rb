# == Schema Information
#
# Table name: categories
#
#  id            :bigint(8)        not null, primary key
#  category_name :string(255)      not null
#  description   :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer          default(0)
#

class Category < ApplicationRecord
    validates :category_name, presence: true, uniqueness: true
    
    has_many :menus
    #has_and_belongs_to_many :menus
    
    def total_menu
      menus.count(:id)
    end
end
