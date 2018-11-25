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

require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
