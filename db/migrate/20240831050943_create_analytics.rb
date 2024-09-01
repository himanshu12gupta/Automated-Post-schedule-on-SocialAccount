class CreateAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics do |t|
      t.references :handler, null: false, foreign_key: true
      t.integer :platform, null: false, default: 0  # Enum for platform (facebook, instagram, linkedin)
      t.string :metric_type, null: false            # Type of metric (e.g., likes, comments, shares)
      t.integer :value, null: false, default: 0     # The actual metric value
      t.datetime :timestamp, null: false            # When the metric was recorded

      t.timestamps
    end

    add_index :analytics, [:platform, :metric_type, :timestamp]
  end
end
