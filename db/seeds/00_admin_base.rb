Rails.logger.backend.info 'SEEDING'
Rails.logger.backend.info '  Seeding users'
puts 'Seeding users'
if User.count == 0
  # As Admin is the first user, it needs a UUID of its own.
  initial_UUID = SecureRandom.uuid
  admin = User.create(user_name: 'Admin',
               password: ENV['admin_pass'],
               password_confirmation: ENV['admin_pass'],
               is_admin: 1,
               last_name: 'Administrator',
               first_name: 'Open Data Quality',
               description: { 'en' => 'Admin user', 
                              'fr' => 'Administrateur', 
                              'de' => 'Administrator',
                              'it' => 'Amministratore' },
               active_from: '2000-01-01',
               active_to: '2100-01-01',
               created_by_id: initial_UUID,
               updated_by_id: initial_UUID,
               owner_id: initial_UUID,
               email: 'frederic.champreux@opendataquality.com')
  admin.confirm
  # Add more users here if needed #
  #                               #
  # ############################# #
  puts "#{User.count} users created."
  Rails.logger.backend.info "  Created users: #{ (User.all.map { |list| list.user_name }).join(', ') }"
  puts '---'
end

