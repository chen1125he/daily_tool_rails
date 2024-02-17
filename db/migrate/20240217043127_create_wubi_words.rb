# frozen_string_literal: true

class CreateWubiWords < ActiveRecord::Migration[6.0]
  def change
    create_table :wubi_words do |t|
      t.string :word, index: true
      t.string :code
      t.text :context
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
