# frozen_string_literal: true

class ChangeWubiWordActive < ActiveRecord::Migration[6.0]
  def change
    change_column :wubi_words, :active, :boolean, default: true
  end
end
