class UserStatusMailer < ActionMailer::Base
	# Use application_mail.html.erb
	layout 'application_mailer'

	# Automatically inject css styles
	include Roadie::Rails::Automatic

	default from: "BorrowTomorrow <staff@borrowtomorrow.io>"

	# Mail when a user status is updated
	def set_mail(user)
		@user 	 = user
		template = @user.status

		case @user.status
			when User.statuses[:inactive]
				subject = "BorrowTomorrow: Activate Your Account"
			when User.statuses[:active]
				subject = "BorrowTomorrow: Your Account Has Been Activated"
			when User.statuses[:warned]
				subject = "BorrowTomorrow: Warning"
			when User.statuses[:suspended]
				subject = "BorrowTomorrow: Your Account Has Been Suspended"
			when User.statuses[:banned]
				subject = "BorrowTomorrow: Your Account Has Been Banned"
		end

		mail(to: @user.email, subject: subject) do |format|
			format.html { render template }
		end
	end

end
