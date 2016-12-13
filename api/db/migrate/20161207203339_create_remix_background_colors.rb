class CreateRemixBackgroundColors < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_background_colors do |t|
      t.string :color

      t.timestamps
    end
  end
end
