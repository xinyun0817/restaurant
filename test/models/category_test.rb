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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
