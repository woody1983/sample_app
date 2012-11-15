namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    admin = User.create!(id: 1,
						 name: "admin",
                         email: "woody.xu@sha.phoenixintl.com.cn",
                         password: "123456789",
                         password_confirmation: "123456789")
    admin.toggle!(:admin)
	
	database_sd5 = Database.create!(db_name: "_SHARE_DATA5",db_project: "ShareData5",db_user: 1, db_pm: 1, db_desc:"Basic Data System")
	database_pixos2 = Database.create!(db_name: "_PIXOS2",db_project: "Pixos2",db_user: 1, db_pm: 1, db_desc:"Pixos2 System")
	database_rb = Database.create!(db_name: "RATE_BRIDGE",db_project: "Rate Bridge 3.1",db_user: 1, db_pm: 1, db_desc:"Data System")
	database_pom = Database.create!(db_name: "POM",db_project: "Po Managent",db_user: 1, db_pm: 1, db_desc:"PO System")
	database_ob = Database.create!(db_name: "ONLINE_BOOKING2",db_project: "Online Booking 2",db_user: 1, db_pm: 1, db_desc:"Booking System")

  end
end

