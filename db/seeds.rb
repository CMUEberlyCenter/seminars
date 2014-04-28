# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Populate each seminar status if it doesn't already exist
['development','locked','published'].each { |status| SeminarStatus.find_or_create_by_key( :key => status) }

# Populate each registration status if it doesn't already exist
#
# TODO: Yeah... I spelled canceled wrong. When you go in to fix this, 
#       make canceled-late a hyphen instead of an underscore.
['pending','confirmed','cancelled','cancelled_late'].
  each { |status| RegistrationStatus.find_or_create_by_key( :key => status ) }

# Populate each attendance status if it doesn't already exist
['attended','attended-incomplete','absent-unexcused','absent-excused'].
  each { |status| AttendanceStatus.find_or_create_by_key( :key => status ) }

# Create certain admins by default if they don't already exist
['meribyte','jmbrooks','hilaryf','rpoprosk'].
  each { |andrewid| Participant.find_or_create_by_andrewid( { :andrewid => andrewid, :is_admin => true },
                                                            :without_protection => true) }

# Create default application-wide settings if they don't already exist
Setting.find_or_create_by_key(
                              :key => "default-tag", 
                              :label => "Default tag for new seminars", 
                              :value => "S13" )

Setting.find_or_create_by_key( 
                              :key => "admin-list-tag", 
                              :label => "List seminars in admin view with tag", 
                              :value => "S13" )
