# CreateUsers - create the users table.
# rubocop:disable Metrics/MethodLength
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :auth0_id
      t.boolean :is_admin, default: false
      t.boolean :is_author, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :auth0_id
  end
end
# rubocop:enable Metrics/MethodLength
