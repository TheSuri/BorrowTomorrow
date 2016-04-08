class UserServicesMailer < ActionMailer::Base
	# Use application_mail.html.erb
	layout 'application_mailer'

	# Automatically inject css styles
	include Roadie::Rails::Automatic
	
	include Rails.application.routes.url_helpers

	default from: "BorrowTomorrow <staff@borrowtomorrow.com>"
	
	# Mail when a user service 'check' status is updated
	def check_updated(user_service)
		@user_service = user_service

		# Status: pending, scheduled_unconfirm, scheduled_confirmed, complete
		template 	= 'check_' + @user_service.status
		# Change the to and subject base on @user_service status
		if @user_service.pending?
			to 		= @user_service.lender.email
			subject = "BorrowTomorrow: #{@user_service.lendee.first_name} Checked Your Service!"
		elsif @user_service.schedule_unconfirm?
			subject = "BorrowTomorrow: Please Confirm Schedule Date and Place"
			to 		= @user_service.lendee.email
		elsif @user_service.schedule_confirmed?
			to 		= @user_service.lender.email
			subject = "BorrowTomorrow: #{@user_service.lendee.first_name} Has Confirmed"
		elsif @user_service.complete?
			to 		= @user_service.lender.email
			subject = "BorrowTomorrow: Service Complete!"
		end

		# Create the mail object
		mail(to: to, subject: subject) do |format|
			format.html { render template }
		end
		
	end

end
