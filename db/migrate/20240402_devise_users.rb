# frozen_string_literal: true

class DeviseUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Additional information
      t.string     :first_name,            limit: 255
      t.string     :last_name,             limit: 255
      t.string     :user_name,             limit: 255,  
                                           null: false,
                                           comment: 'Alternate login name for the user'
      t.string     :language,              limit: 255,  
                                           default: 'en',
                                           comment: 'User language used to display translated content'
      t.json       :description,           default: { "en": "New user", "fr": "Nouvel utilisateur", "de": "Neuer Nutzer", "it": "Nuovo utente" }, 
                                           comment: 'Description is translated.'
      t.datetime   :active_from,           default: -> { 'current_date' }, 
                                           comment: 'Validity period'
      t.datetime   :active_to
      t.boolean    :is_admin,              default: false, 
                                           comment: 'Flags application-wide administrator'
      t.boolean    :is_active,             default: true,
                                           comment: 'As nothing can be deleted, flags objects removed from the knowledge base'
      t.belongs_to :owner,                 type: :uuid,    
                                           null: false, 
                                           comment: 'All managed objects have a owner'
      t.references :created_by,            type: :uuid, 
                                           null: false,
                                           comment: 'UUID of the user who created the record'
      t.references :updated_by,            type: :uuid, 
                                           null: false,
                                           comment: 'UUID of the last user who updated the record'
      t.string     :touched_by,            limit: 255,
                                           comment: 'Name of the last user or process who updated the record'                                                 

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
