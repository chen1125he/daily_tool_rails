# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WubiWord, type: :model do
  it { should validate_presence_of(:word) }
  it { should validate_uniqueness_of(:word) }
  it { should validate_presence_of(:code) }
end
