class CreateFuneral < ActiveRecord::Migration[5.2]
  def change
    create_table :funerals do |t|
      t.integer :burial_cremation
      t.string :funeral_home_name
      t.string :funeral_home_phone
      t.string :funeral_home_address
      t.integer :type_of_service
      t.boolean :plot_purchased
      t.boolean :coffin_or_urn_purchased
      t.boolean :package_purchased
      t.boolean :docs_or_contract_exist
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
