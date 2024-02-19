# frozen_string_literal: true

class WubiWord < ApplicationRecord
  validates :word, presence: true, uniqueness: true
  validates :code, presence: true
end
